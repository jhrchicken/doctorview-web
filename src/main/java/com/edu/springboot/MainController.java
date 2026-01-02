package com.edu.springboot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.doctor.IDoctorService;
import com.edu.springboot.hospital.DetailDTO;
import com.edu.springboot.hospital.HospitalDTO;
import com.edu.springboot.hospital.IHospitalService;



@Controller
public class MainController {
	
	@Autowired
	IHospitalService hospitalDAO;
	@Autowired
	IDoctorService doctorDAO;
	
	
	@RequestMapping("/")
	public String home(Model model) {
		
		// 병원
		List<HospitalDTO> hospList = hospitalDAO.listHospByLikecount();
		for (HospitalDTO hospital : hospList) {
			hospital.setApi_idx(Integer.parseInt(hospitalDAO.selectHospIdx(hospital.getName())));
			// 입점 병원 상세 정보
    		DetailDTO detailDTO = hospitalDAO.selectDetail(hospital.getId());
    		if (detailDTO != null) {
    			if (detailDTO.getPhoto() != null) {
    				hospital.setPhoto(detailDTO.getPhoto());
    			}
    			if (detailDTO.getIntroduce() != null) {
    				hospital.setIntroduce(detailDTO.getIntroduce());
    			}
    		}
		}
		
		// 의사
		List<DoctorDTO> doctorList = doctorDAO.listDoctorByLikecount();
		for (DoctorDTO doctor : doctorList) {
			doctor.setHospname(doctorDAO.selectHospName(doctor));
		}
		
		model.addAttribute("hospList", hospList);
		model.addAttribute("doctorList", doctorList);
		return "home";
	}
	
	@RequestMapping("/release.do")
	public String release() {
		return "common/release";
	}
	


}