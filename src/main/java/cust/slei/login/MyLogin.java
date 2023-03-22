package cust.slei.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cust.slei.util.AbstractController;

@Controller
public class MyLogin extends AbstractController {
    @RequestMapping(value={"/adm/login"})
    public String admLogin(){
        return "adm/login";
    }
}
