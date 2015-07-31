/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author Rahul
 *
 */
@Controller
public class ManageUserController {

	private static final Logger logger = Logger.getLogger(ManageUserController.class);
	
	@Autowired
	ManageUserService userService;
	
	   @RequestMapping("/app/searchusers")
	   public String searchUsers(@RequestParam("card_no") String card_no,
			   @RequestParam("borrower_name") String borrower_name,ModelMap model) {
	     
	      List<User> users = userService.searchUsers(card_no, borrower_name);
	      logger.debug(card_no + "  size = " + users.size());
	      model.addAttribute("message", users.size() + " == Hello 1 MVC Framework!");
	      model.addAttribute("userList", users);
	      return "usersearch";
	   }

	   @RequestMapping("/app/createnewuser")
	   public String createNewUser(@RequestParam("fname") String fname,
			   @RequestParam("lname") String lname,
			   @RequestParam("address") String address,
			   @RequestParam("city") String city,
			   @RequestParam("state") String state,
			   @RequestParam("phone") String phone,
			   ModelMap model) {
	      
	      User user = new User();
	      user.setFname(fname);
	      user.setLname(lname);
	      user.setAddress(address);
	      user.setCity(city);
	      user.setState(state);
	      user.setPhone(phone);
	      int result = userService.createNewUser(user);
	      logger.debug(fname + "  " + lname);
	      model.addAttribute("result", result);
	      model.addAttribute("fname", fname);
	      model.addAttribute("lname", lname);
	      
	      List<User> users = userService.searchUsers("","");
	      model.addAttribute("userList", users);
	      
	      return "usersearch";
	   }
	
}
