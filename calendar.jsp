<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />
<%!
    private static Map eventMap = new HashMap();
  static {
    eventMap.put("20240101", "お正月");
    eventMap.put("20231225", "クリスマス");
    eventMap.put("20231231", "大晦日");
    eventMap.put("20231115", "七五三");
    eventMap.put("20230109", "成人式");
    eventMap.put("20231009", "体育祭");
    eventMap.put("20230909", "文化祭");
    eventMap.put("20231224", "クリスマス・イブ");
    eventMap.put("20230717", "祇園祭");
    eventMap.put("20231031", "ハロウィン");
    eventMap.put("20230808", "花火大会");
    eventMap.put("20230610", "父の日");
    eventMap.put("20230513", "母の日");
    eventMap.put("20230314", "ホワイトデー");
    eventMap.put("20230203", "節分");
    eventMap.put("20230707", "七夕");
    eventMap.put("20230505", "こどもの日");
    eventMap.put("20230401", "イースター");
    eventMap.put("20230303", "ひな祭り");
    eventMap.put("20230214", "バレンタイン");
  }
%>
<%
String year = (String)request.getParameter("year");
String month = (String)request.getParameter("month");
String day = (String)request.getParameter("day");
LocalDate localDate = null;
if (year == null || month == null || day == null) {
	localDate = LocalDate.now();
	year = String.valueOf(localDate.getYear());
    month = String.valueOf(localDate.getMonthValue());
    day = String.valueOf(localDate.getDayOfMonth());
  } else {
	  localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
  }
  String[] dates = { year, month, day };
  pageContext.setAttribute("dates", dates);  
  pageContext.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
  
  String event = (String)eventMap.get(year + month + day);
  pageContext.setAttribute("event", event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
	<form method="post" action="/jsp/calendar.jsp">
		<ul>
			<li><input type="text" name="year" value="${param['year']}" /><label for="year">年</label><input type="text" name="month" value="${param['month']}" /><label for="month">月</label><input type="text" name="day" value="${param['day']}" /><label for="day">日</label></li>
			<li><input type="submit" value="送信" />
			<li><c:out value="${fn:join(dates, '/')}" /> (<fmt:formatDate value="${date}" pattern="E" />)</li>
      		<li><c:out value="${event}" /></li>
		</ul>
 	</form>
</body>
</html>