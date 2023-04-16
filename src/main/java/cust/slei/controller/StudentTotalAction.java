package cust.slei.controller;

import com.alibaba.fastjson.JSON;
import cust.slei.DAO.StudentDAO;
import cust.slei.DAO.StudentTotalDAO;

import cust.slei.domain.StudentTotal;
import cust.slei.util.AbstractController;
import cust.slei.util.ListTemplate;
import cust.slei.util.page.Page;
import cust.slei.util.page.PageFactory;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

@Controller
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS)
public class StudentTotalAction extends AbstractController {


    @Autowired
    private StudentTotalDAO studentTotalDAO;

    @Autowired
    private StudentDAO studentDAO;

    @Autowired
    private JdbcTemplate jt;

    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/listTotalAjax")
    public String list(int rows, int page, StudentTotalSearch search, Model model) {
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
        List<Map<String, Object>> data = new ArrayList<>();
        for (Map<String, Object> stringObjectMap :  (List<Map<String, Object>>) result) {
            double[] temp=new double[6];
            temp[0] = (double) stringObjectMap.get("de");
            temp[1] = (double) stringObjectMap.get("zhi");
            temp[2] = (double) stringObjectMap.get("ti");
            temp[3] = (double) stringObjectMap.get("mei");
            temp[4] = (double) stringObjectMap.get("lao");
            temp[5] = (double) stringObjectMap.get("total");
            Map<String, Object> map = new HashMap<>();
            map.put("value", Arrays.toString(temp));
            map.put("name", stringObjectMap.get("name").toString());
            data.add(map);
        }
        System.out.println(data);
        model.addAttribute("dataList", data);
        return "json";
    }


//    @RequiresPermissions({"xsgl"})
    @RequestMapping(value = "/adm/student/getData")
    public String getData(StudentTotalSearch search) {
        ListTemplate lt = studentTotalDAO.getLt();
        String sql = search.buildSQL();
        sql += " order by st.id desc";
        Page mlpage = PageFactory.getPage();
        mlpage.setPageNum(1);
        mlpage.setRecordNum(9999);
        List<Object> params = search.getParams();
        List<Map<String, Object>> result = mlpage.getOnePage(sql, params, jt);
        List<Map<String, Object>> data = new ArrayList<>();
        for (Map<String, Object> stringObjectMap : result) {
            double[] temp=new double[6];
            temp[0] = (double) stringObjectMap.get("de");
            temp[1] = (double) stringObjectMap.get("zhi");
            temp[2] = (double) stringObjectMap.get("ti");
            temp[3] = (double) stringObjectMap.get("mei");
            temp[4] = (double) stringObjectMap.get("lao");
            temp[5] = (double) stringObjectMap.get("total");
            Map<String, Object> map = new HashMap<>();
            map.put("value", Arrays.toString(temp));
            map.put("name", stringObjectMap.get("name"));
            data.add(map);
        }
        System.out.println(data);
        System.out.println(result);
        String s = JSON.toJSONString(data);
        return s;
    }

//    @Transactional
//    @RequiresPermissions({"xsgl"})
//    @RequestMapping("/adm/student/deleteAjax")
//    public String delete(String id, Model model) {
//        studentDaliyDAO.delete(id);
//        model.addAttribute("retMsg", "删除成功");
//        return "json";
//    }

    @Transactional
    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/addTotalAjax")
    public String add(StudentTotal studenttotal, Model model) {
//		log.debug(user.toString());
        studenttotal.sumAll();
        studentTotalDAO.insert(studenttotal);
        model.addAttribute("retCode", "OK");
        model.addAttribute("retMsg", "添加成功");
        return "json";
    }

//    @RequestMapping("getResult")
//    public String getResult(String id,Model model){
//        String status = "ok";
//        log.debug(id);
//        if(id==null){
//            status = "学号为空请重新输入";
//        }
//        Student student = studentDAO.loadOne(id);
//        log.debug(student.toString());
//        if(Objects.equals(student,null)){
//            status = "学号有误请重新输入";
//        }
//        List<StudentTotal> lt = studentTotalDAO.loadMore("where id = ?",new Object[]{id});
//        log.debug(lt.toString());
//        if(lt.size() == 0){
//            status = "暂无考试信息";
//        }
//        model.addAttribute("status",status);
//        model.addAttribute("name",student.getName());
//        model.addAttribute("result",lt);
//        return "json";
//    }



    @Transactional
    @RequiresPermissions({"xsgl"})
    @RequestMapping("/adm/student/updateTotalAjax")
    public String update(Model model, StudentTotal studentTotal) {
        studentTotalDAO.update(studentTotal);
        model.addAttribute("retCode", "OK");
        model.addAttribute("retMsg", "更新成功");
        return "json";
    }

}
