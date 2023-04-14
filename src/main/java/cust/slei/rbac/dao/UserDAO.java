package cust.slei.rbac.dao;

import cust.slei.rbac.domain.User;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class UserDAO extends DAOTemplate<User> {
    public UserDAO(){
        clazz = User.class;
        pkColumns = new String[]{"username"};
        comColumns = new String[]{"name","class_number","email","job","phone"};
        tableName = "user";
        init();
    }
}
