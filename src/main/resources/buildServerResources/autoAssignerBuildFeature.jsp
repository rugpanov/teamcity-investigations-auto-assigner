<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ page import="jetbrains.buildServer.investigationsAutoAssigner.common.Constants" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm" scope="request"/>
<c:set var="onSecondFailureDescriptionNoteDivId">onSecondFailureDescriptionNoteDivId</c:set>

<script type="text/javascript">
  BS.AutoAssignerFeature = BS.AutoAssignerFeature || {};

  BS.AutoAssignerFeature.showHomePage = function () {
    var winSize = BS.Util.windowSize();
    BS.Util.popupWindow('https://confluence.jetbrains.com/display/TCD18/Investigations+Auto+Assigner',
      'Investigations Auto Assigner', {width: 0.9 * winSize[0], height: 0.9 * winSize[1]});
    BS.stopPropagation(event);
  };

  BS.AutoAssignerFeature.updateDelayOnSecondFailureNoteVisibility = function () {
    var selectedValue = $('${Constants.SHOULD_DELAY_ASSIGNMENTS}').options[$('${Constants.SHOULD_DELAY_ASSIGNMENTS}').selectedIndex].value;
    if ('true' == selectedValue) {
      $('${onSecondFailureDescriptionNoteDivId}').show();
    } else {
      $('${onSecondFailureDescriptionNoteDivId}').hide();
    }
  };

  BS.AutoAssignerFeature.updateDelayOnSecondFailureNoteVisibility();
</script>

<tr>
  <td colspan="2">
    <em>This build feature automatically assigns investigations of build failures to users.
      <a class='helpIcon' onclick='BS.AutoAssignerFeature.showHomePage()' title='View help'>
        <i class='icon icon16 tc-icon_help_small'></i>
      </a>
    </em>
  </td>
</tr>
<tr>
<tr>
  <th>
    <label for="<%= Constants.SHOULD_DELAY_ASSIGNMENTS%>">Assign: </label>
  </th>
  <td>
    <props:selectProperty name="${Constants.SHOULD_DELAY_ASSIGNMENTS}" onchange="BS.AutoAssignerFeature.updateDelayOnSecondFailureNoteVisibility();">
      <props:option value="">On first failure</props:option>
      <props:option value="${true}">On second failure</props:option>
    </props:selectProperty>
    <div id="${onSecondFailureDescriptionNoteDivId}">
      <span class="smallNote">This option delays assignment until the failure repeats twice in a row.
      Use to prevent wrong assignments in projects with many flaky tests.</span>
    </div>

  </td>
</tr>
<tr>
  <th>
    <label for="<%= Constants.DEFAULT_RESPONSIBLE%>">Default assignee:</label>
  </th>
  <td>
    <props:textProperty name="<%= Constants.DEFAULT_RESPONSIBLE%>" className="longField textProperty_max-width js_max-width"/>
    <span class="smallNote">Username of a user to assign the investigation to if no other assignee can be found.</span>
  </td>
</tr>
<tr>
  <th>
    <label for="<%= Constants.USERS_TO_IGNORE%>">Users to ignore:</label>
  </th>
  <td>
    <props:multilineProperty name="<%= Constants.USERS_TO_IGNORE%>" cols="58" rows="6" linkTitle="Edit users to ignore"
                             expanded="true" className="longField"/>
    <span class="smallNote">The newline-separated list of usernames to exclude from investigations auto-assignment.</span>
  </td>
</tr>
<tr class="advancedSetting">
  <th>
    <label>Build problems to ignore:</label>
  </th>
  <td>
    <props:checkboxProperty name="<%= Constants.SHOULD_IGNORE_COMPILATION_PROBLEMS%>"/>
      <label for="<%= Constants.SHOULD_IGNORE_COMPILATION_PROBLEMS%>">Compilation error build problems</label>
      <br/>
    <props:checkboxProperty name="<%=Constants.SHOULD_IGNORE_EXITCODE_PROBLEMS%>"/>
      <label for="<%=Constants.SHOULD_IGNORE_EXITCODE_PROBLEMS%>">Exit code build problems</label>
      <span class="smallNote">Type of build problems to ignore in investigations auto-assignment.</span>
</tr>