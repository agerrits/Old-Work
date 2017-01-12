<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:aefe="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/errors"
                xmlns:htd="http://www.example.org/WS-HT"
                xmlns:ns1="http://www.solazyme.com/RequestIn/HTA"
                xmlns:htdp="http://www.example.org/WS-HT/protocol"
                xmlns:api="http://www.example.org/WS-HT/api"
                xmlns:trt="http://schemas.active-endpoints.com/b4p/wshumantask/2007/10/aeb4p-task-rt.xsd"
                xmlns:ns="http://www.solazyme.com/RFQ/PurchaseBPEL"
                xmlns:aemeta="urn:ae:xslrendering:meta"
                aemeta:operation="PurRequestApprove"
                aemeta:portType="ns1:PurchaseApprovePT"
                aemeta:processName="ns:PurchaseBPEL"
                aemeta:projectName="PurchaseRequest"
                aemeta:taskName="ApproveTask"
                aemeta:templateType="presentation"
                version="1.0"><!-- Import base stylesheets. --><xsl:import href="urn:/aeb4p/rendering/xsl/ae_escapexml.xsl"/>
   <xsl:import href="urn:/aeb4p/rendering/xsl/ae_default_task.xsl"/>
   <xsl:output encoding="UTF-8" indent="yes" method="html"/>
   <!-- Override 'ae_task_workitem' template to emit html form skeleton --><xsl:template name="ae_task_workitem" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <xsl:param name="taskDisplayStatus"/>
      <div id="formwrapper">
         <form class="workitemdatagrid aevalidating_form" id="taskdetail_workitem_form"
               method="POST">
            <xsl:attribute name="action">task?taskId=<xsl:value-of select="$taskId"/>
            </xsl:attribute>
            <!-- Required action URI and hidden fields. Do not modify this as ajax/ui framework is dependent on these values. --><input class="aetaskworkitem_taskid" name="taskId" type="hidden">
               <xsl:attribute name="value">
                  <xsl:value-of select="$taskId"/>
               </xsl:attribute>
            </input>
            <input class="aetaskworkitem_submitmode" name="aetaskworkitem_submitmode"
                   type="hidden"
                   value="xsl"/>
            <!-- Build form contents --><xsl:call-template name="ae_task_workitem_formbody">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
            <!-- Render submit buttons if the task has been started and the person has permissions --><xsl:if test="$taskStatus='IN_PROGRESS' and (//trt:permissions/trt:setOutput or //trt:permissions/trt:setFault or //trt:permissions/trt:deleteFault)">
               <xsl:call-template name="ae_task_workitem_formsubmit"/>
            </xsl:if>
         </form>
      </div>
   </xsl:template>
   <!-- Template for rendering form contents (task input, output and faults) --><xsl:template name="ae_task_workitem_formbody" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Call separate templates to build div contents for task input,output and faults. --><xsl:call-template name="ae_task_workitem_inputsection">
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
         <xsl:when test="$taskStatus='IN_PROGRESS'"><!-- Render editable input controls. --><xsl:call-template name="ae_task_workitem_outputsection_editable">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
            <!-- Render fault as editable data. --><xsl:call-template name="ae_task_workitem_faultsection_editable">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise><!-- Render output values as read-only data. --><xsl:call-template name="ae_task_workitem_outputsection">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
            <!-- Render fault as read-only data. --><xsl:call-template name="ae_task_workitem_faultsection">
               <xsl:with-param name="taskId" select="$taskId"/>
               <xsl:with-param name="taskStatus" select="$taskStatus"/>
               <xsl:with-param name="finalState" select="$finalState"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!-- Template for rendering form submit buttons --><xsl:template name="ae_task_workitem_formsubmit" xml:space="default">
      <div style="display:inline;">
         <p style="padding:0;margin:10px;text-align:left;">
            <a href="" id="aetask_cmd_save" style="display:inline;margin:0 10px 0 0;"
               title="Save Data"> Save </a>
            <a href="" id="aetask_cmd_cancel" style="display:inline;margin:0 10px 0 0;"
               title="Reset Form"> Clear </a>
         </p>
      </div>
   </xsl:template>
   <!-- Template for rendering task input section --><xsl:template name="ae_task_workitem_inputsection" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Input: --><div id="workitemdata_inputsection" style="width:100%;">
         <table class="workitem_table">
            <tr>
               <th class="workitem_table_section" colspan="2">
                  <strong>Input:</strong>
               </th>
            </tr>
            <tr>
               <td colspan="2">
                  <div xmlns:ns="http://www.solazyme.com/PurchaseRequest" class="aepart"
                       id="aepart_PurRequestApproveRequest">
                     <xsl:variable name="PurRequestApproveRequest_ns_PurReqID"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurReqID"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurReqName"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurReqName"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurUserID"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurUserID"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurDep"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurDep"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurVendor"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurVendor"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurDateReq"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurDateReq"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_Shipping"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:Shipping"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurSubmit"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurSubmit"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurTotalQuantPr"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurTotalQuantPr"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurTotalCost"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurTotalCost"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurReason"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurReason"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurComments"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQMain/ns:PurComments"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_LineItemID"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:LineItemID"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurRequestID"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:PurRequestID"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_PurOrderID"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:PurOrderID"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_LineProductNum"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:LineProductNum"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_Quantity"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:Quantity"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_ItemCost"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:ItemCost"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_TotalCost"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:TotalCost"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_Description"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:Description"/>
                     <xsl:variable name="PurRequestApproveRequest_ns_Received"
                                   select="//trt:operational/trt:input/trt:part[@name='PurRequestApproveRequest']/ns:PurRequestFull/ns:RFQDetail/ns:PRQLineItems/ns:Received"/>
                     <table border="1">
                        <tr>
                           <td colspan="2">
                              <strong>PurRequestApproveRequest</strong>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurReqID:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurReqID"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurReqName:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurReqName"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurUserID:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurUserID"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurDep:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurDep"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurVendor:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurVendor"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurDateReq:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurDateReq"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Shipping:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_Shipping"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurSubmit:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurSubmit"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurTotalQuantPr:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurTotalQuantPr"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurTotalCost:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurTotalCost"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurReason:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurReason"/>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>PurComments:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveRequest_ns_PurComments"/>
                           </td>
                        </tr>
                        <table border="1">
                            <tr bgcolor="#9acd32">
                                <th>LineItem</th>
                                <th>PurRequest</th>
                                <th>PurOrderID</th>
                                <th>ProductNum</th>
                                <th>ItemCost</th>
                                <!-- added quantity here -->
                                <th>Quantity</th>
                                <th>TotalCost</th>
                                <th>Description</th>
                            </tr>
                            <xsl:for-each select="//*[local-name(.)='RFQDetail']/Document/Element">
								<tr>
									<td><xsl:value-of select="line_item_id" /></td>
									<td><xsl:value-of select="purchase_req_id" /></td>
									<td><!-- --></td>
									<td><xsl:value-of select="product_num" /></td>
									<td><xsl:value-of select="item_cost" /></td>
									<td><xsl:value-of select="quantity" /></td>
									<td><xsl:value-of select="total_cost" /></td>
									<td><xsl:value-of select="description" /></td>
								</tr>
							</xsl:for-each>
                            <tr>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_LineItemID"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_PurRequestID"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_PurOrderID"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_LineProductNum"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_Quantity"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_ItemCost"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_TotalCost"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_Description"/></td>
                               <td><xsl:value-of select="$PurRequestApproveRequest_ns_Received"/></td>
                            </tr>
                        </table>
                     </table>
                  </div>
               </td>
            </tr>
         </table>
      </div>
   </xsl:template>
   <!-- Template for rendering task output section (read-only) --><xsl:template name="ae_task_workitem_outputsection" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Output section --><div class="aeoutputsection" id="workitemdata_outputsection" style="width:100%;">
         <table class="workitem_table">
            <tr>
               <th class="workitem_table_section" colspan="2">
                  <strong>Output:</strong>
               </th>
            </tr>
            <tr>
               <td colspan="2">
                  <div xmlns:ns2="http://domain.com/purchaserequest"
                       xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                       class="aepart"
                       id="aepart_PurRequestApproveResponse">
                     <xsl:variable name="PurRequestApproveResponse_ns2_Approval"
                                   select="//trt:operational/trt:output/trt:part[@name='PurRequestApproveResponse']/soapenv:Envelope/soapenv:Body/ns2:purchaseRequest/ns2:Header/ns2:Approval"/>
                     <table border="1">
                        <tr>
                           <td colspan="2">
                              <strong>PurRequestApproveResponse</strong>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>Approval:</strong>
                           </td>
                           <td>
                              <xsl:value-of select="$PurRequestApproveResponse_ns2_Approval"/>
                           </td>
                        </tr>
                     </table>
                  </div>
               </td>
            </tr>
         </table>
      </div>
   </xsl:template>
   <!-- Template for rendering task output section html form controls(editable) --><xsl:template name="ae_task_workitem_outputsection_editable" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Output Section --><div class="aeoutputsection" id="workitemdata_outputsection" style="width:100%;">
         <table class="workitem_table">
            <tr>
               <th class="workitem_table_section" colspan="2">
                  <strong>Output:</strong>
               </th>
            </tr>
            <tr>
               <td colspan="2">
                  <div xmlns:ns2="http://domain.com/purchaserequest"
                       xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                       class="aepart"
                       id="aepart_PurRequestApproveResponse">
                     <xsl:variable name="PurRequestApproveResponse_ns2_Approval"
                                   select="//trt:operational/trt:output/trt:part[@name='PurRequestApproveResponse']/soapenv:Envelope/soapenv:Body/ns2:purchaseRequest/ns2:Header/ns2:Approval"/>
                     <table border="1">
                        <tr>
                           <td colspan="2">
                              <strong>PurRequestApproveResponse</strong>
                           </td>
                        </tr>
                        <tr>
                           <td class="label" style="width:15%;">
                              <strong>
                                 <label for="PurRequestApproveResponse_ns2_Approval">Approval</label>:</strong>
                           </td>
                           <td>
                              <input class="aestringtype workitemdata_output workitemdata_editable"
                                     id="PurRequestApproveResponse_ns2_Approval"
                                     name="PurRequestApproveResponse_ns2_Approval"
                                     title="Approval (string type)"
                                     type="text">
                                 <xsl:attribute name="value">
                                    <xsl:value-of select="$PurRequestApproveResponse_ns2_Approval"/>
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
   <!-- Template for rendering fault messages (editable fields) --><xsl:template name="ae_task_workitem_faultsection_editable" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Fault section - call separate tempates to render each fault message in a separate div. --><div class="aefault aefaultsection" id="workitemdata_clearfault" style="width:100%;">
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
   <!-- Template for rendering fault messages (read only)--><xsl:template name="ae_task_workitem_faultsection" xml:space="default">
      <xsl:param name="taskId"/>
      <xsl:param name="taskStatus"/>
      <xsl:param name="finalState"/>
      <!-- Fault section - call separate tempates to render each fault message in a separate div. --></xsl:template>
</xsl:stylesheet>