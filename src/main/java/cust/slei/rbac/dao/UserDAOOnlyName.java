package cust.slei.rbac.dao;

import cust.slei.rbac.domain.User;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class UserDAOOnlyName extends DAOTemplate<User> {
    public UserDAOOnlyName(){
        clazz = User.class;
        pkColumns = new String[]{"username"};
        comColumns = new String[]{"name"};
        tableName = "user";
        init();
    }
}
