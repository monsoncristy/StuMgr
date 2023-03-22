package cust.slei.rbac.dao;

import org.springframework.stereotype.Component;

import cust.slei.rbac.domain.Role;
import cust.slei.util.DAOTemplate;

@Component
public class RoleDAO extends DAOTemplate<Role> {

    public RoleDAO(){
        clazz = Role.class;
        pkColumns = new String[]{"role_id"};
        comColumns = new String[]{"role"};
        tableName = "role";
        init();
    }
}
