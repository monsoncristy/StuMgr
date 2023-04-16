package cust.slei.controller;

import cust.slei.util.search.Search;

public class StudentTotalSearch extends Search {

    @Override
    protected String getProjections(){
        StringBuffer sb = new StringBuffer();
        sb.append(" st.id id,grade,cgroup,name,calss,");
        sb.append(" de,zhi,ti,mei,lao,total");
        return sb.toString();
    }

    @Override
    protected String getTables(){
        StringBuffer sb = new StringBuffer();
        sb.append(" student st left outer join stu_total sr on st.id = sr.id ");
        return sb.toString();
    }
}
