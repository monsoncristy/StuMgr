package cust.slei.DAO;

import cust.slei.domain.Student;
import cust.slei.domain.StudentDaliy;
import cust.slei.domain.StudentTotal;
import cust.slei.rbac.domain.User;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class StudentTotalDAO extends DAOTemplate<StudentTotal> {
    public StudentTotalDAO(){
        clazz = StudentTotal.class;
        pkColumns = new String[]{"id"};
        comColumns = new String[]{"grade","name","calss",
                "de", "zhi","ti","mei","lao","total"};
        tableName = "stu_total";
        init();
    }
}
