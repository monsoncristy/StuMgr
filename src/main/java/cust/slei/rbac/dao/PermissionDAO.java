package cust.slei.rbac.dao;

import cust.slei.rbac.domain.Permission;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class PermissionDAO extends DAOTemplate<Permission> {

    public PermissionDAO(){
        clazz = Permission.class;
        pkColumns = new String[]{"perm_id"};
        listProjections = new String[]{"perm_id", "perm"};
        comColumns = new String[]{"perm"};
        tableName = "permission";
        init();
    }
}
