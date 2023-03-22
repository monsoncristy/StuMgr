package cust.slei.rbac.dao;

import cust.slei.rbac.domain.UserRole;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class UserRoleDAO extends DAOTemplate<UserRole> {
	public UserRoleDAO(){
        clazz = UserRole.class;
        pkColumns = new String[]{"username", "role_id"};
        comColumns = new String[]{};
        tableName = "user_to_role";
        init();
    }
}
