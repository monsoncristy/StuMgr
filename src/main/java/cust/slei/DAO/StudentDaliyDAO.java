package cust.slei.DAO;

import cust.slei.domain.Student;
import cust.slei.domain.StudentDaliy;
import cust.slei.rbac.domain.User;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class StudentDaliyDAO extends DAOTemplate<StudentDaliy> {
    public StudentDaliyDAO(){
        clazz = StudentDaliy.class;
        pkColumns = new String[]{"id"};
        comColumns = new String[]{"hygiene","awards","discipline"};
        tableName = "stu_daliyperform";
        init();
    }
}
