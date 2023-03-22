package cust.slei.rbac;

import javax.servlet.http.HttpServletRequest;

import cust.slei.util.excel.ColumnTypeConverter;
import cust.slei.util.excel.ExportHeaders;
import cust.slei.util.excel.Header;
import cust.slei.util.excel.ImportExport;
import cust.slei.util.excel.ImportHeaders;

public class UsrIE implements ImportExport {

	@Override
	public ImportHeaders getImportHeaders(HttpServletRequest request) {
		// TODO Auto-generated method stub
		ImportHeaders h = new ImportHeaders("c_user");
		h.addHeader(new Header("用户名", "C_USERNAME", null, ColumnTypeConverter.STRING));
		h.addHeader(new Header("姓名", "C_NAME", null, ColumnTypeConverter.STRING));
		return h;
	}

	@Override
	public ExportHeaders getExportHeaders(HttpServletRequest request) {
		// TODO Auto-generated method stub
		ExportHeaders h = new ExportHeaders("c_user");
		h.addHeader(new Header("用户名", "C_USERNAME", null, ColumnTypeConverter.STRING));
		h.addHeader(new Header("姓名", "C_NAME", null, ColumnTypeConverter.STRING));
		
		return h;
	}

}
