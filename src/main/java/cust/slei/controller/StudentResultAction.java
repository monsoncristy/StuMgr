package cust.slei.controller;

import cust.slei.DAO.StudentResultDAO;
import cust.slei.domain.StudentResult;
import cust.slei.util.AbstractController;
import cust.slei.util.page.Page;
import cust.slei.util.page.PageFactory;
import cust.slei.util.search.Search;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS)
public class StudentResultAction extends AbstractController {


    @Autowired
    private StudentResultDAO studentResultDAO;

    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/listAjax")
    public String list(int rows, int page, Search search, Model model) {
        String sql = search.buildSQL(studentResultDAO);
        sql += " order by id desc";
        Page mlpage = PageFactory.getPage();
        mlpage.setPageNum(page);
        mlpage.setRecordNum(rows);
        List<Object> params = search.getParams();
        //params.add(cp);
        List<?> result = mlpage.getOnePage(sql, params, studentResultDAO);
        model.addAttribute("pages", mlpage);
        model.addAttribute("result", result);
        return "json";
    }

    @Transactional
    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/deleteAjax")
    public String delete(String id, Model model) {
        studentResultDAO.delete(id);
        model.addAttribute("retMsg", "删除成功");
        return "json";
    }

    @Transactional
    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/addAjax")
    public String add(StudentResult studentresult, Model model) {
//		log.debug(user.toString());
        studentResultDAO.insert(studentresult);
        model.addAttribute("retCode", "OK");
        model.addAttribute("retMsg", "添加成功");
        return "json";
    }

    @Transactional
    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/updateAjax")
    public String update(Model model, StudentResult studentresult) {
        studentResultDAO.update(studentresult);
        model.addAttribute("retCode", "OK");
        model.addAttribute("retMsg", "更新成功");
        return "json";
    }

}