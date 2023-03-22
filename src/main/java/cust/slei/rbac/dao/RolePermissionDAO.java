package cust.slei.rbac.dao;

import org.springframework.stereotype.Component;

import cust.slei.rbac.domain.RolePermission;
import cust.slei.util.DAOTemplate;

@Component
public class RolePermissionDAO extends DAOTemplate<RolePermission> {

    public RolePermissionDAO(){
        clazz = RolePermission.class;
        pkColumns = new String[]{"role_id", "perm_id"};
        comColumns = new String[]{};
        tableName = "role_to_perm";
        init();
    }
}
