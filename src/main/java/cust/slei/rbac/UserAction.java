package cust.slei.rbac;

import cust.slei.login.PasswordService;
import cust.slei.rbac.dao.UserDAO;
import cust.slei.rbac.dao.UserDAOIncPwd;
import cust.slei.rbac.domain.User;
import cust.slei.util.AbstractController;
import cust.slei.util.BusinessException;
import cust.slei.util.excel.Export;
import cust.slei.util.excel.Import;
import cust.slei.util.page.Page;
import cust.slei.util.page.PageFactory;
import cust.slei.util.search.Search;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

@Controller
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS)
public class UserAction extends AbstractController {
	
	@Autowired
	private JdbcTemplate jt;
	
	@Autowired
	private UserDAO userDAO2;//没有密码
	
	@Autowired
	private UserDAOIncPwd userDAO;
	
	@Autowired
	private PasswordService passwordService;

	@RequiresPermissions({"yhgl"})
	@RequestMapping("/adm/users/listAjax")
	public String list(int rows, int page, Search search, Model model) {
		String sql = search.buildSQL(userDAO2);
		sql += " order by username asc";
		Page mlpage = PageFactory.getPage();
		mlpage.setPageNum(page);
		mlpage.setRecordNum(rows);
		List<Object> params = search.getParams();
		//params.add(cp);
		List<?> result = mlpage.getOnePage(sql, params, userDAO2);
		model.addAttribute("pages", mlpage);
		model.addAttribute("result", result);
		return "json";
	}

	@Transactional
	@RequiresPermissions({"yhgl"})
	@RequestMapping("/adm/users/deleteAjax")
	public String delete(String username, Model model) {
		userDAO2.delete(username);
		model.addAttribute("retMsg", "删除成功");
		return "json";
	}

	@Transactional
	@RequiresPermissions({"yhgl"})
	@RequestMapping("/adm/users/addAjax")
	public String add(User user, Model model) {
//		log.debug(user.toString());
		user.setPassword(passwordService.encryptPassword(user.getUsername()));
		userDAO2.insert(user);
		model.addAttribute("retCode", "OK");
		model.addAttribute("retMsg", "添加成功");
		return "json";
	}

	@Transactional
	@RequiresPermissions({"yhgl"})
	@RequestMapping("/adm/users/updateAjax")
	public String update(Model model, User user) {
		userDAO2.update(user);
		model.addAttribute("retCode", "OK");
		model.addAttribute("retMsg", "更新成功");
		return "json";
	}
	
	@RequiresPermissions({"yhgl"})
	@RequestMapping("/adm/users/export")
	public String export(HttpServletResponse response, Model model) {
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=users.xls");
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("sheet1");
		Export export = new Export();
		export.exportRecords(null, new UsrIE(), sheet, jt, "", null);
		
		try(OutputStream out = response.getOutputStream()) {
			wb.write(out);
		}catch(IOException ex) {
			ex.printStackTrace();
		}
    	return null;
	}
	
	@RequiresPermissions({"yhgl"})
	@RequestMapping("/adm/users/importAjax")
	public String importUser(HttpServletResponse response, MultipartFile file, Model model) {
		if(file == null || file.isEmpty()) {
			throw new BusinessException("请上传Excel文件");
		}
		if(file.getSize() > 10*1000*1000) {
			throw new BusinessException("文件不能超过10MB");
		}
		try(InputStream in = file.getInputStream()){
			log.info("------开始导入信息------");
			HSSFWorkbook wbs = new HSSFWorkbook(in);
			HSSFSheet childSheet = wbs.getSheetAt(0);
			Import imp = new Import();
			imp.importRecords(null, new UsrIE(), childSheet, jt, false);
			log.info("-------导入信息成功------");
		}catch(IOException e){
			throw new BusinessException("I/O错误",e);
		}
		model.addAttribute("retCode","OK");
		model.addAttribute("retMsg","导入成功");
		return "json";
	}

	@ResponseBody
	@RequiresPermissions({"yhgl"})
	@RequestMapping("/adm/users/existAjax")
	public boolean existAjax(String username, Model model) {
		User adm = userDAO2.loadOne(username);
		return adm == null;
	}
}
