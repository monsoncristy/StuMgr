package cust.slei.DAO;

import cust.slei.domain.Student;
import cust.slei.rbac.domain.User;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class StudentDAO extends DAOTemplate<Student> {
    public StudentDAO(){
        clazz = Student.class;
        pkColumns = new String[]{"id"};
        comColumns = new String[]{"grade","cgroup","name","calss"};
        tableName = "student";
        init();
    }
}
