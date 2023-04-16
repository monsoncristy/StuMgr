package cust.slei.DAO;

import cust.slei.domain.StudentTotal;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class StudentTotalDAO extends DAOTemplate<StudentTotal> {
    public StudentTotalDAO(){
        clazz = StudentTotal.class;
        pkColumns = new String[]{"id"};
        comColumns = new String[]{
                "de", "zhi","ti","mei","lao","total"};
        tableName = "stu_total";
        init();
    }

}
