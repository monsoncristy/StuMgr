package cust.slei.controller;

import cust.slei.DAO.StudentDAO;
import cust.slei.DAO.StudentDaliyDAO;
import cust.slei.domain.Student;
import cust.slei.domain.StudentDaliy;
import cust.slei.domain.StudentResult;
import cust.slei.util.AbstractController;
import cust.slei.util.page.Page;
import cust.slei.util.page.PageFactory;
import cust.slei.util.search.Search;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Objects;

@Controller
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS)
public class StudentDaliyAction extends AbstractController {//类似于监听器


    @Autowired
    private StudentDaliyDAO studentDaliyDAO;

    @Autowired
    private StudentDAO studentDAO;

    @Autowired
    private JdbcTemplate jt;

    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/listDaliyAjax")
    public String list(int rows, int page, StudentDaliySearch search, Model model) {
        String sql = search.buildSQL();
        sql += " order by st.id desc";
        Page mlpage = PageFactory.getPage();
        mlpage.setPageNum(page);
        mlpage.setRecordNum(rows);
        List<Object> params = search.getParams();
        //params.add(cp);
        List<?> result = mlpage.getOnePage(sql, params, jt);
        model.addAttribute("pages", mlpage);
        model.addAttribute("result", result);
        return "json";
    }

//    @Transactional
//    @RequiresPermissions({"xsgl"})
//    @RequestMapping("/adm/student/deleteAjax")
//    public String delete(String id, Model model) {
//        studentDaliyDAO.delete(id);
//        model.addAttribute("retMsg", "删除成功");
//        return "json";
//    }
@RequestMapping("getDaliyperform")
public String getResult(String id,Model model){
    String status = "ok";
    log.debug(id);
    if(id==null){
        status = "学号为空请重新输入";
    }
    Student student = studentDAO.loadOne(id);
    log.debug(student.toString());
    if(Objects.equals(student,null)){
        status = "学号有误请重新输入";
    }
    List<StudentDaliy> lt = studentDaliyDAO.loadMore("where id = ?",new Object[]{id});
    log.debug(lt.toString());
    if(lt.size() == 0){
        status = "暂无平时表现";
    }
    model.addAttribute("status",status);
    model.addAttribute("name",student.getName());
    model.addAttribute("result",lt);
    return "json";
}




    @Transactional
    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/addDaliyAjax")
    public String add(StudentDaliy studentdaliy, Model model) {
//		log.debug(user.toString());
        studentDaliyDAO.insert(studentdaliy);
        model.addAttribute("retCode", "OK");
        model.addAttribute("retMsg", "添加成功");
        return "json";
    }

    @Transactional
    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/updatedaliyAjax")
    public String update(Model model, StudentDaliy studentDaliy) {
        studentDaliyDAO.update(studentDaliy);
        model.addAttribute("retCode", "OK");
        model.addAttribute("retMsg", "更新成功");
        return "json";
    }

}
