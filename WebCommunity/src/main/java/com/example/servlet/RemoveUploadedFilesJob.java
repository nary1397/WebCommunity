package com.example.servlet;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.example.domain.AttachVO;
import com.example.repository.AttachDAO;

public class RemoveUploadedFilesJob implements Job {

	private AttachDAO attachDAO = AttachDAO.getInstance();

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// 오전 2시에 작업 수행하기

		// 어제날짜 구하기
		Calendar cal = Calendar.getInstance(); // 현재날짜시간 정보를 가진 Calendar 객체 가져오기
		cal.add(Calendar.DATE, -1); // 현재날짜시간에서 하루 빼기

		// 어제날짜 년월일 폴더경로 구하기
		Date yesterdayDate = cal.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String strDate = sdf.format(yesterdayDate); // "2021/08/12"

		String path = "C:/ksw/upload/" + strDate; // "C:/ksw/upload/2021/08/12"
		System.out.println("path : " + path);

		// 어제날짜 경로를 파일객체로 준비
		File dir = new File(path);
		// 어제날짜 경로 폴더안에 있는 파일목록을 배열로 가져오기
		File[] files = dir.listFiles();
		// 배열을 리스트로 변환하기
		List<File> fileList = Arrays.asList(files);

		// DB에서 년월일 경로에 해당하는 첨부파일 리스트 가져오기
		AttachDAO attachDAO = AttachDAO.getInstance();
		List<AttachVO> attachList = attachDAO.getAttachesByUploadpath(strDate);

		// ===================================

		// 1) String요소를 가지는 List 두개로 contains() 포함여부로 비교하는 방법
		
		// fileList에서 파일명만 가지는 filenameList 만들기
		List<String> filenameList = new ArrayList<>();
		for (File file : fileList) {
			filenameList.add(file.getName());
		}

		// attachList에서 파일명만 가지는 dbFilenameList 만들기
		List<String> dbFilenameList = new ArrayList<>();
		for (AttachVO attach : attachList) {
			dbFilenameList.add(attach.getFilename());
		}

		// ===================================

		for (String filename : filenameList) { // 실제 폴더에 있는 파일
			// 실제 파일이 DB에서 가져온 목록에 포함되어 있지 않으면
			if (dbFilenameList.contains(filename) == false) {
				File delFile = new File(path, filename);
				
				if (delFile.exists()) { // 해당 파일 존재하면
					delFile.delete();
					
					// 파일명 출력하기
					System.out.println(delFile.getName() + " 파일 삭제됨..");
				}
			}
		} // for

	} // execute
	
}
