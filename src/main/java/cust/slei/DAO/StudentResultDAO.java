package cust.slei.DAO;

import cust.slei.domain.StudentResult;
import cust.slei.util.DAOTemplate;
import org.springframework.stereotype.Component;

@Component
public class StudentResultDAO extends DAOTemplate<StudentResult> {
    public StudentResultDAO(){
        clazz = StudentResult.class;
        pkColumns = new String[]{"id","test_name"};
        comColumns = new String[]{
                "chinese","math","english","physics","chemistry","biology"
                ,"history","geography","politics","all_result"};
        tableName = "stu_result";
        init();
    }
}
