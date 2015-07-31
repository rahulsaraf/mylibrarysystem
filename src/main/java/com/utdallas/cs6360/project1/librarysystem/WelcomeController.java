/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Rahul
 *
 */
@Controller
@RequestMapping("/app")
public class WelcomeController{
 
   @RequestMapping(value="/hello", method=RequestMethod.GET)
   public String redirectWelcomePage(ModelMap model) {
      model.addAttribute("message", "Hello 1 MVC Framework!");
      return "welcome";
   }

   @RequestMapping("/search")
   public String redirectSearchPage(ModelMap model) {
      model.addAttribute("message", "Hello 1 MVC Framework!");
      return "search";
   }
   
   @RequestMapping("/loansearch")
   public String redirectLoanSearchPage(ModelMap model) {
      model.addAttribute("message", "Hello 1 MVC Framework!");
      return "loansearch";
   }
   
   
   @RequestMapping("/manageusers")
   public String redirectManageUsersPage(ModelMap model) {
      model.addAttribute("message", "Hello 1 MVC Framework!");
      return "usersearch";
   }
   
   @RequestMapping("/managefines")
   public String redirectManageFinesPage(ModelMap model) {
      model.addAttribute("message", "Hello 1 MVC Framework!");
      return "managefines";
   }
}