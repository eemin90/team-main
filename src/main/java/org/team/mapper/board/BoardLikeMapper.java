package org.team.mapper.board;

import org.apache.ibatis.annotations.Param;
import org.team.domain.board.BoardLikeVO;

public interface BoardLikeMapper {

	public int like(BoardLikeVO vo);
	public void plusCnt(BoardLikeVO vo);
	public int cancelLike(BoardLikeVO vo);
	public void minusCnt(BoardLikeVO vo);

	public int dislike(BoardLikeVO vo);
	public void displusCnt(BoardLikeVO vo);
	public int cancelDislike(BoardLikeVO vo);
	public void disminusCnt(BoardLikeVO vo);
	
	public BoardLikeVO read(@Param("bno") String bno, @Param("userid") String userid);
	public BoardLikeVO read1(@Param("bno") String bno, @Param("userid") String userid);
	
	public void deleteLikeByBno(Long bno);
	public void deleteDislikeByBno(Long bno);

}
