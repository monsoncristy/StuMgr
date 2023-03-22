package cust.slei.login;

import java.util.List;

import cust.slei.rbac.dao.RolePermissionDAO;
import cust.slei.rbac.dao.UserDAOIncPwd;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import cust.slei.rbac.dao.UserDAOIncPwd;
import cust.slei.rbac.dao.UserRoleDAO;
import cust.slei.rbac.domain.RolePermission;
import cust.slei.rbac.domain.User;
import cust.slei.rbac.domain.UserRole;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MyJdbcRealm extends JdbcRealm {
	@Autowired
	private UserDAOIncPwd userDao;
	@Autowired
	private UserRoleDAO userRoleDao;
	@Autowired
	private RolePermissionDAO rolePermissionDao;
	@Autowired
	private PasswordService passwordService;

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		// TODO Auto-generated method stub
		final MyUsernamePasswordToken upToken = (MyUsernamePasswordToken) token;
		final String username = upToken.getUsername();
		final String password = new String(upToken.getPassword());

		// Null username is invalid
		if (username == null) {
			throw new AccountException("Null usernames are not allowed by this realm.");
		}

		SimpleAuthenticationInfo info = null;

		User u = userDao.loadOne("where username=?", new Object[] { username });

		if (u != null) {
			boolean valid = passwordService.validatePassword(password, u.getPassword());
			if(valid) {
				String rn = getName();
				SimplePrincipalCollection spc = new SimplePrincipalCollection();
				spc.add(username, rn);
				info = new SimpleAuthenticationInfo(spc, upToken.getPassword());
			}
		}
		return info;
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Object obj = principals.getPrimaryPrincipal();
		log.info("pp:{}", obj);
		SimpleAuthorizationInfo ai = new SimpleAuthorizationInfo();
		List<UserRole> urs = userRoleDao.loadMore("where username=?", new Object[] { obj });
		if(urs.isEmpty()) {
			return ai;
		}
		Object[] params = new Object[urs.size()];
		int i = 0;
		for (UserRole ur : urs) {
			ai.addRole(ur.getRoleId());
			params[i++] = ur.getRoleId();
		}
		List<RolePermission> rps = rolePermissionDao
				.loadMore("where role_id in " + buildQuestionMarks(urs.size()), params);
		for (RolePermission rp : rps) {
			ai.addStringPermission(rp.getPermId());
		}
		return ai;
	}

	private String buildQuestionMarks(int n) {
		StringBuffer sb = new StringBuffer(n * 2 + 1);
		sb.append('(');
		for (int i = 0; i < n; i++) {
			sb.append('?');
			sb.append(',');
		}
		sb.deleteCharAt(n * 2);
		sb.append(')');
		return sb.toString();
	}
}
