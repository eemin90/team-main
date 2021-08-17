package org.team.service.help;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.team.domain.help.HBoardVO;
import org.team.domain.help.HBoardCriteria;
import org.team.domain.help.HFileVO;
import org.team.mapper.help.HBoardMapper;
import org.team.mapper.help.HFileMapper;
import org.team.mapper.help.HReplyMapper;

import lombok.Setter;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service 
public class HBoardServiceImpl implements HBoardService {
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	public HBoardServiceImpl() {  
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
	private HBoardMapper mapper;
	
	@Setter (onMethod_ = @Autowired)
	private HReplyMapper replyMapper;
	
	@Setter (onMethod_ = @Autowired)
	private HFileMapper fileMapper;
		
	@Override
	public void register(HBoardVO board) {
		mapper.insertSelectKey(board);
	}
	
	@Override
	@Transactional
	public void register(HBoardVO board, MultipartFile file) {
		register(board);
		
		if (file != null && file.getSize() > 0) {
			HFileVO vo = new HFileVO();
			vo.setHno(board.getHno());
			vo.setFileName(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			upload(board, file); 	
		}
	}

	private void upload(HBoardVO board, MultipartFile file) {
		
		try (InputStream is = file.getInputStream()) {

			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key("help/" + board.getHno() + "/" + file.getOriginalFilename())
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
	public HBoardVO get(Long hno) {
		return mapper.read(hno);
	}

	@Override
	public boolean modify(HBoardVO board) {
		return mapper.update(board) == 1;
	}
	
	@Override
	@Transactional
	public boolean modify(HBoardVO board, MultipartFile file) {
		
		if (file != null & file.getSize() > 0) {
			
			HBoardVO oldBoard = mapper.read(board.getHno());
			removeFile(oldBoard);
			upload(board, file);
			
			fileMapper.deleteByHno(board.getHno());
			
			HFileVO vo = new HFileVO();
			vo.setHno(board.getHno());
			vo.setFileName(file.getOriginalFilename());
			fileMapper.insert(vo);
		
		}
		return modify(board);
	}

	@Override
	@Transactional
	public boolean remove(Long hno) { 
		
		replyMapper.deleteByHno(hno);
		
		HBoardVO vo = mapper.read(hno); 
		removeFile(vo);
		
		fileMapper.deleteByHno(hno);
		
		int cnt = mapper.delete(hno);
		
		return cnt == 1;
	} 

	private void removeFile(HBoardVO vo) {

		String key = vo.getHno() + "/" + vo.getFileName();
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
		
		
	}

	@Override
	public List<HBoardVO> getList(HBoardCriteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(HBoardCriteria cri) {
		return mapper.getTotalCount(cri);
	}

}
