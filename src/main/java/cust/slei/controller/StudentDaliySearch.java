package cust.slei.controller;

import cust.slei.util.search.Search;

public class StudentDaliySearch extends Search {

    @Override
    protected String getProjections(){
        StringBuffer sb = new StringBuffer();
        sb.append(" st.id id,grade,cgroup,name,calss,");
        sb.append(" hygiene,awards,discipline");
        return sb.toString();
    }

    @Override
    protected String getTables(){
        StringBuffer sb = new StringBuffer();
        sb.append(" student st left outer join stu_daliyperform sr on st.id = sr.id ");
        return sb.toString();
    }
}
