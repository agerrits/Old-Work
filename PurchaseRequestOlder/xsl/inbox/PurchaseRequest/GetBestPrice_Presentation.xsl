<xsl:stylesheet xmlns:aefe="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/errors" xmlns:aemeta="urn:ae:xslrendering:meta" xmlns:api="http://www.example.org/WS-HT/api" xmlns:htd="http://www.example.org/WS-HT" xmlns:htdp="http://www.example.org/WS-HT/protocol" xmlns:ns="http://PurchaseRequest" xmlns:ns1="http://domain.com/purchaseFRequest/3" xmlns:trt="http://schemas.active-endpoints.com/b4p/wshumantask/2007/10/aeb4p-task-rt.xsd" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" aemeta:operation="purchaseRequest" aemeta:portType="ns1:rfq" aemeta:processName="ns:PurchaseRequest" aemeta:projectName="PurchaseRequest" aemeta:taskName="GetBestPrice" aemeta:templateType="presentation" version="1.0">
   <!-- Import base stylesheets. -->
   <xsl:import href="urn:/aeb4p/rendering/xsl/ae_escapexml.xsl"/>
   <xsl:import href="urn:/aeb4p/rendering/xsl/ae_default_task.xsl"/>
   <xsl:output encoding="UTF-8" indent="yes" method="html"/>
   <!-- Override 'ae_task_workitem' template to emit html form skeleton -->
   <xsl:template name="ae_task_workitem" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <xsl:param name="taskDisplayStatus"/>
      <div id="formwrapper">
         <form class="workitemdatagrid aevalidating_form" id="taskdetail_workitem_form" method="POST">
            <xsl:attribute name="action">task?taskId=<xsl:value-of select="$taskId"/>
            </xsl:attribute>
            <!-- Required action URI and hidden fields. Do not modify this as ajax/ui framework is dependent on these values. -->
            <input class="aetaskworkitem_taskid" name="taskId" type="hidden">
               <xsl:attribute name="value">
                  <xsl:value-of select="$taskId"/>
               </xsl:attribute>
            </input>
            <input class="aetaskworkitem_submitmode" name="aetaskworkitem_submitmode" type="hidden" value="xsl"/>
            <!-- Build form contents -->
            <xsl:call-template name="ae_task_workitem_formbody">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
            <!-- Render submit buttons if the task has been started and the person has permissions -->
            <xsl:if test="$taskStatus='IN_PROGRESS' and (//trt:permissions/trt:setOutput or //trt:permissions/trt:setFault or //trt:permissions/trt:deleteFault)">
               <xsl:call-template name="ae_task_workitem_formsubmit"/>
            </xsl:if>
         </form>
      </div>
   </xsl:template>
   <!-- Template for rendering form contents (task input, output and faults) -->
   <xsl:template name="ae_task_workitem_formbody" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Call separate templates to build div contents for task input,output and faults. -->
      <xsl:call-template name="ae_task_workitem_inputsection">
         <xsl:with-param name="taskId" select="$taskId"/>
         <xsl:with-param name="taskStatus" select="$taskStatus"/>
         <xsl:with-param name="finalState" select="$finalState"/>
      </xsl:call-template>
      <table style="workitem_table">
         <tr>
            <td class="workitem_table_section" colspan="2">
               <select id="workitemdata_selection" name="aetaskworkitem_selection">
                  <xsl:choose>
                     <xsl:when test="$taskStatus='IN_PROGRESS'">
                        <option value="_aesetoutput_">Set Output</option>
                     </xsl:when>
                     <xsl:when test="$taskStatus='COMPLETED'">
                        <option selected="true" value="_aesetoutput_">Output</option>
                        <xsl:if test="//trt:operational/trt:fault/@name">
                           <xsl:variable name="faultName" select="//trt:operational/trt:fault/@name"/>
                           <option>
                              <xsl:attribute name="value">_aesetfault_<xsl:value-of select="$faultName"/>
                              </xsl:attribute>Fault - <xsl:value-of select="$faultName"/>
                           </option>
                        </xsl:if>
                     </xsl:when>
                     <xsl:when test="$taskStatus='FAILED'">
                        <option value="_aesetoutput_">Output</option>
                        <xsl:variable name="faultName" select="//trt:operational/trt:fault/@name"/>
                        <option selected="true">
                           <xsl:attribute name="value">_aesetfault_<xsl:value-of select="$faultName"/>
                           </xsl:attribute>Fault - <xsl:value-of select="$faultName"/>
                        </option>
                     </xsl:when>
                     <xsl:otherwise>
                        <option value="_aesetoutput_">Output</option>
                     </xsl:otherwise>
                  </xsl:choose>
               </select>
            </td>
         </tr>
      </table>
      <xsl:choose>
         <xsl:when test="$taskStatus='IN_PROGRESS'">
            <!-- Render editable input controls. -->
            <xsl:call-template name="ae_task_workitem_outputsection_editable">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
            <!-- Render fault as editable data. -->
            <xsl:call-template name="ae_task_workitem_faultsection_editable">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <!-- Render output values as read-only data. -->
            <xsl:call-template name="ae_task_workitem_outputsection">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
            <!-- Render fault as read-only data. -->
            <xsl:call-template name="ae_task_workitem_faultsection">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!-- Template for rendering form submit buttons -->
   <xsl:template name="ae_task_workitem_formsubmit" xml:space="default">
      <div style="display:inline;">
         <p style="padding:0;margin:10px;text-align:left;">
            <a href="" id="aetask_cmd_save" style="display:inline;margin:0 10px 0 0;" title="Save Data"> Save </a>
            <a href="" id="aetask_cmd_cancel" style="display:inline;margin:0 10px 0 0;" title="Reset Form"> Clear </a>
         </p>
      </div>
   </xsl:template>
   <!-- Template for rendering task input section -->
   <xsl:template name="ae_task_workitem_inputsection" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Input: -->
      <div id="workitemdata_inputsection" style="width:100%;">
         <table class="workitem_table">
            <tr>
               <th class="workitem_table_section" colspan="2">
                  <strong>Input:</strong>
               </th>
            </tr>
            <tr>
               <td colspan="2">
                  <div xmlns:ns="http://domain.com/purchaserequest" class="aepart" id="aepart_purchaseRequestRequest">
                     <xsl:variable name="purchaseRequestRequest_ns_date" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:date"/>
                     <xsl:variable name="purchaseRequestRequest_ns_by" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:by"/>
                     <xsl:variable name="purchaseRequestRequest_ns_vendor" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:vendor"/>
                     <xsl:variable name="purchaseRequestRequest_ns_reason" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:reason"/>
                     <xsl:variable name="purchaseRequestRequest_ns_shipping" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:shipping"/>
                     <xsl:variable name="purchaseRequestRequest_ns_eta" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:eta"/>
                     <xsl:variable name="purchaseRequestRequest_ns_approved" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:approved"/>
                     <xsl:variable name="purchaseRequestRequest_ns_comments" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Header/ns:comments"/>
                     <xsl:variable name="purchaseRequestRequest_ns_item_attr_LineNum" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Items/ns:item/@LineNum"/>
                     <xsl:variable name="purchaseRequestRequest_ns_productNo" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Items/ns:item/ns:productNo"/>
                     <xsl:variable name="purchaseRequestRequest_ns_description" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Items/ns:item/ns:description"/>
                     <xsl:variable name="purchaseRequestRequest_ns_quantity" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Items/ns:item/ns:quantity"/>
                     <xsl:variable name="purchaseRequestRequest_ns_price" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Items/ns:item/ns:price"/>
                     <xsl:variable name="purchaseRequestRequest_ns_total" select="//trt:operational/trt:input/trt:part[@name='purchaseRequestRequest']/ns:purchaseRequest/ns:Items/ns:item/ns:total"/>
                     <table border="1">
                        <tr>
                           <td colspan="2">
                              <strong>purchaseRequestRequest</strong>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Date:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_date"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>By:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_by"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Vendor:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_vendor"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Reason:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_reason"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Shipping:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_shipping"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Eta:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_eta"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Approved:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_approved"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Comments:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_comments"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>LineNum:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_item_attr_LineNum"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>ProductNo:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_productNo"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Description:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_description"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Quantity:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_quantity"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Price:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_price"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Total:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestRequest_ns_total"/>
                           </td>
                        </tr>
                     </table>
                  </div>
               </td>
            </tr>
         </table>
      </div>
   </xsl:template>
   <!-- Template for rendering task output section (read-only) -->
   <xsl:template name="ae_task_workitem_outputsection" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Output section -->
      <div class="aeoutputsection" id="workitemdata_outputsection" style="width:100%;">
         <table class="workitem_table">
            <tr>
               <th class="workitem_table_section" colspan="2">
                  <strong>Output:</strong>
               </th>
            </tr>
            <tr>
               <td colspan="2">
                  <div xmlns:ns="http://domain.com/purchaserequest" class="aepart" id="aepart_purchaseRequestResponse">
                     <xsl:variable name="purchaseRequestResponse_ns_date" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:date"/>
                     <xsl:variable name="purchaseRequestResponse_ns_by" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:by"/>
                     <xsl:variable name="purchaseRequestResponse_ns_vendor" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:vendor"/>
                     <xsl:variable name="purchaseRequestResponse_ns_reason" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:reason"/>
                     <xsl:variable name="purchaseRequestResponse_ns_shipping" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:shipping"/>
                     <xsl:variable name="purchaseRequestResponse_ns_eta" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:eta"/>
                     <xsl:variable name="purchaseRequestResponse_ns_approved" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:approved"/>
                     <xsl:variable name="purchaseRequestResponse_ns_comments" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:comments"/>
                     <xsl:variable name="purchaseRequestResponse_ns_item_attr_LineNum" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/@LineNum"/>
                     <xsl:variable name="purchaseRequestResponse_ns_productNo" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:productNo"/>
                     <xsl:variable name="purchaseRequestResponse_ns_description" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:description"/>
                     <xsl:variable name="purchaseRequestResponse_ns_quantity" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:quantity"/>
                     <xsl:variable name="purchaseRequestResponse_ns_price" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:price"/>
                     <xsl:variable name="purchaseRequestResponse_ns_total" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:total"/>
                     <table border="1">
                        <tr>
                           <td colspan="2">
                              <strong>purchaseRequestResponse</strong>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Date:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_date"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>By:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_by"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Vendor:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_vendor"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Reason:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_reason"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Shipping:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_shipping"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Eta:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_eta"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Approved:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_approved"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Comments:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_comments"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>LineNum:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_item_attr_LineNum"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>ProductNo:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_productNo"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Description:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_description"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Quantity:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_quantity"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Price:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_price"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Total:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$purchaseRequestResponse_ns_total"/>
                           </td>
                        </tr>
                     </table>
                  </div>
               </td>
            </tr>
         </table>
      </div>
   </xsl:template>
   <!-- Template for rendering task output section html form controls(editable) -->
   <xsl:template name="ae_task_workitem_outputsection_editable" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Output Section -->
      <div class="aeoutputsection" id="workitemdata_outputsection" style="width:100%;">
         <table class="workitem_table">
            <tr>
               <th class="workitem_table_section" colspan="2">
                  <strong>Output:</strong>
               </th>
            </tr>
            <tr>
               <td colspan="2">
                  <div xmlns:ns="http://domain.com/purchaserequest" class="aepart" id="aepart_purchaseRequestResponse">
                     <xsl:variable name="purchaseRequestResponse_ns_date" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:date"/>
                     <xsl:variable name="purchaseRequestResponse_ns_by" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:by"/>
                     <xsl:variable name="purchaseRequestResponse_ns_vendor" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:vendor"/>
                     <xsl:variable name="purchaseRequestResponse_ns_reason" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:reason"/>
                     <xsl:variable name="purchaseRequestResponse_ns_shipping" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:shipping"/>
                     <xsl:variable name="purchaseRequestResponse_ns_eta" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:eta"/>
                     <xsl:variable name="purchaseRequestResponse_ns_approved" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:approved"/>
                     <xsl:variable name="purchaseRequestResponse_ns_comments" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Header/ns:comments"/>
                     <xsl:variable name="purchaseRequestResponse_ns_item_attr_LineNum" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/@LineNum"/>
                     <xsl:variable name="purchaseRequestResponse_ns_productNo" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:productNo"/>
                     <xsl:variable name="purchaseRequestResponse_ns_description" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:description"/>
                     <xsl:variable name="purchaseRequestResponse_ns_quantity" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:quantity"/>
                     <xsl:variable name="purchaseRequestResponse_ns_price" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:price"/>
                     <xsl:variable name="purchaseRequestResponse_ns_total" select="//trt:operational/trt:output/trt:part[@name='purchaseRequestResponse']/ns:purchaseRequest/ns:Items/ns:item/ns:total"/>
                     <table border="1">
                        <tr>
                           <td colspan="2">
                              <strong>purchaseRequestResponse</strong>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_date">Date</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_date" name="purchaseRequestResponse_ns_date" title="Date (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_date"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_by">By</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_by" name="purchaseRequestResponse_ns_by" title="By (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_by"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_vendor">Vendor</label>:</strong>
                           </td>
                           <td>
                              <input class="aenumbertype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_vendor" name="purchaseRequestResponse_ns_vendor" title="Vendor (number type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_vendor"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_reason">Reason</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_reason" name="purchaseRequestResponse_ns_reason" title="Reason (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_reason"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_shipping">Shipping</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_shipping" name="purchaseRequestResponse_ns_shipping" title="Shipping (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_shipping"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_eta">Eta</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_eta" name="purchaseRequestResponse_ns_eta" title="Eta (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_eta"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_approved">Approved</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_approved" name="purchaseRequestResponse_ns_approved" title="Approved (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_approved"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_comments">Comments</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_comments" name="purchaseRequestResponse_ns_comments" title="Comments (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_comments"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_item_attr_LineNum">LineNum</label>:</strong>
                           </td>
                           <td>
                              <input class="aenumbertype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_item_attr_LineNum" name="purchaseRequestResponse_ns_item_attr_LineNum" title="LineNum (number type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_item_attr_LineNum"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_productNo">ProductNo</label>:</strong>
                           </td>
                           <td>
                              <input class="aenumbertype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_productNo" name="purchaseRequestResponse_ns_productNo" title="ProductNo (number type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_productNo"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_description">Description</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_description" name="purchaseRequestResponse_ns_description" title="Description (string type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_description"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_quantity">Quantity</label>:</strong>
                           </td>
                           <td>
                              <input class="aenumbertype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_quantity" name="purchaseRequestResponse_ns_quantity" title="Quantity (number type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_quantity"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_price">Price</label>:</strong>
                           </td>
                           <td>
                              <input class="aenumbertype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_price" name="purchaseRequestResponse_ns_price" title="Price (number type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_price"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="purchaseRequestResponse_ns_total">Total</label>:</strong>
                           </td>
                           <td>
                              <input class="aenumbertype workitemdata_output workitemdata_editable" id="purchaseRequestResponse_ns_total" name="purchaseRequestResponse_ns_total" title="Total (number type)" type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$purchaseRequestResponse_ns_total"/>
                                 </xsl:attribute>
                              </input>
                           </td>
                        </tr>
                     </table>
                  </div>
               </td>
            </tr>
         </table>
      </div>
   </xsl:template>
   <!-- Template for rendering fault messages (editable fields) -->
   <xsl:template name="ae_task_workitem_faultsection_editable" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Fault section - call separate tempates to render each fault message in a separate div. -->
      <div class="aefault aefaultsection" id="workitemdata_clearfault" style="width:100%;">
         <table class="workitem_table">
            <tr>
               <th class="workitem_table_section" colspan="2">
                  <strong>Clear Fault:</strong>
               </th>
            </tr>
            <tr>
               <td colspan="2">
			     			Clear fault data.			     		
			     		</td>
            </tr>
         </table>
      </div>
   </xsl:template>
   <!-- Template for rendering fault messages (read only)-->
   <xsl:template name="ae_task_workitem_faultsection" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Fault section - call separate tempates to render each fault message in a separate div. -->
   </xsl:template>
</xsl:stylesheet>
