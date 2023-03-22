package cust.slei.rbac;

import cust.slei.util.ListTemplate;
import cust.slei.util.search.Search;

public class UsersNotInRoleSearch extends Search {

	@Override
	protected String getTables(ListTemplate lt) {
		// TODO Auto-generated method stub
		return "(select a.* from user a left outer join (select username from user_to_role where role_id=?) b on a.username=b.username where b.username is null) c";
	}
}
