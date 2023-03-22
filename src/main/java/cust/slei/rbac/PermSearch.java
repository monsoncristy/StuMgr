package cust.slei.rbac;

import cust.slei.util.search.SimpleSearch;

public class PermSearch extends SimpleSearch {
	
	public PermSearch() {
		columns = new String[]{"perm_id", "perm"};
		operators = new String[] {"like", "like"};
		logicalopts = new String[] {"or", "or"};
		orders = new String[] {"asc", "none"};
	}

}
