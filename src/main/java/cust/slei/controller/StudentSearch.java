package cust.slei.controller;

import cust.slei.util.ListTemplate;
import cust.slei.util.search.Search;

public class StudentSearch extends Search {

    @Override
    public String getProjections(ListTemplate lt){
        return "id,grade,'group',name,calss";
    }



}
