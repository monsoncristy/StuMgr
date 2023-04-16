package cust.slei.controller;

import cust.slei.util.search.Search;

public class StudentResultSearch extends Search {

    @Override
    protected String getProjections(){
        StringBuffer sb = new StringBuffer();
        sb.append(" st.id id,grade,cgroup,name,calss,");
        sb.append("chinese,math,english,physics,chemistry,biology,history,geography,politics,all_result ");
        return sb.toString();
    }

    @Override
    protected String getTables(){
        StringBuffer sb = new StringBuffer();
        sb.append(" student st left outer join stu_result sr on st.id = sr.id ");
        return sb.toString();
    }
}
