package org.team.service.board;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.team.domain.board.BoardCriteria;
import org.team.domain.board.BoardVO;
import org.team.domain.board.FileVO;
import org.team.mapper.board.BoardLikeMapper;
import org.team.mapper.board.BoardMapper;
import org.team.mapper.board.FileMapper;
import org.team.mapper.board.ReplyMapper;

import lombok.Setter;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service 
public class BoardServiceImpl implements BoardService {
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	public BoardServiceImpl() {  
		this.bucketName = "choongang-eemin90";
		this.profileName = "spring1";
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
		
	}

	@Setter (onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter (onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	@Setter (onMethod_ = @Autowired)
	private FileMapper fileMapper;
	
	@Setter (onMethod_ = @Autowired)
	private BoardLikeMapper likeMapper;
		
	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);
	}
	
	@Override
	@Transactional
	public void register(BoardVO board, MultipartFile file) {
		register(board);
		
		if (file != null && file.getSize() > 0) {
			FileVO vo = new FileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			upload(board, file); 	
		}
	}

	private void upload(BoardVO board, MultipartFile file) {
		
		try (InputStream is = file.getInputStream()) {

			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key("board/" + board.getBno() + "/" + file.getOriginalFilename())
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, file.getSize()));
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		return mapper.update(board) == 1;
	}
	
	@Override
	@Transactional
	public boolean modify(BoardVO board, MultipartFile file) {
		
		if (file != null & file.getSize() > 0) {
			
			BoardVO oldBoard = mapper.read(board.getBno());
			removeFile(oldBoard);
			upload(board, file);
			
			fileMapper.deleteByBno(board.getBno());
			
			FileVO vo = new FileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			fileMapper.insert(vo);
		
		}
		return modify(board);
	}

	@Override
	@Transactional
	public boolean remove(Long bno) { 
		
		likeMapper.deleteLikeByBno(bno);
		likeMapper.deleteDislikeByBno(bno);
		
		replyMapper.deleteByBno(bno);
		
		BoardVO vo = mapper.read(bno); 
		removeFile(vo);
		
		fileMapper.deleteByBno(bno);
		
		int cnt = mapper.delete(bno);
		
		return cnt == 1;
	} 

	private void removeFile(BoardVO vo) {

		String key = vo.getBno() + "/" + vo.getFileName();
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
		
		
	}

	@Override
	public List<BoardVO> getList(BoardCriteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(BoardCriteria cri) {
		return mapper.getTotalCount(cri);
	}

}
