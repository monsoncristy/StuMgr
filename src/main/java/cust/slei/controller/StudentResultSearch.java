package cust.slei.controller;

import cust.slei.util.ListTemplate;
import cust.slei.util.search.Search;

public class StudentResultSearch extends Search {

    @Override
    public String getProjections(ListTemplate lt){

        return "id,grade,name,calss,chinese,math,english," +
                "physics,chemistry,biology,history,geography," +
                "politics,all_result";
    }



}
