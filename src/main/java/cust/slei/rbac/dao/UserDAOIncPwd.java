package cust.slei.rbac.dao;

import cust.slei.rbac.domain.User;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class UserDAOIncPwd extends DAOTemplate<User> {
    public UserDAOIncPwd(){
        clazz = User.class;
        pkColumns = new String[]{"username"};
        listProjections = new String[]{"username"};
        comColumns = new String[]{"password"};
        tableName = "user";
        init();
    }

}
