package cust.slei.rbac;

import cust.slei.login.PasswordService;
import cust.slei.rbac.dao.UserDAOIncPwd;
import cust.slei.rbac.domain.User;
import cust.slei.util.AbstractController;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS)
public class PasswordAction extends AbstractController {

    @Autowired
    private UserDAOIncPwd userDAO;

    @Autowired
    private PasswordService passwordService;

    @Transactional
    @RequiresPermissions({"yhgl"})
    @RequestMapping("/adm/users/resetPassword")
    public String resetPassword(String username, Model model) {
        String newPi = passwordService.newPwd();
        String password = passwordService.encryptPassword(newPi);
        User user = userDAO.loadOne(username);
        user.setPassword(password);
        userDAO.update(user);
        model.addAttribute("retMsg", "您的密码重置成功，新的密码为："+newPi);
        return "json";
    }

}
