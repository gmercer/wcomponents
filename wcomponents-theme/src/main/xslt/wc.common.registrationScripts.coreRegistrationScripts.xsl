<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ui="https://github.com/bordertech/wcomponents/namespace/ui/v1.0" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
	<!--
		This template is a helper for "registrationScripts" which does set up and "requires" for components which need pre-initialisation registration.

		This template is never called directly except by the template "registrationScripts" and is split out for ease of override and maintenance.
	-->
	<xsl:template name="coreRegistrationScripts">
		<xsl:variable name="componentGroups" select=".//ui:componentGroup"/>
		<xsl:variable name="dialogs" select=".//ui:dialog"/>
		<xsl:variable name="dataListCombos" select=".//ui:dropdown[@data and @type and not(@readOnly)]|.//ui:suggestions[@data]"/>
		<xsl:variable name="dataListComponents" select=".//ui:dropdown[@data and not(@type) and not(@readOnly)]|.//ui:listbox[@data and not(@readOnly)]|.//ui:shuffler[@data and not(@readOnly)]"/>
		<xsl:variable name="filedrops" select=".//ui:multifileupload[@ajax or @dropzone]"/>
		<xsl:variable name="multiDDData" select=".//ui:multidropdown[@data and not(@readOnly)]"/>
		<xsl:variable name="popups" select=".//ui:popup"/>
		<xsl:variable name="redirects" select=".//ui:redirect"/>
		<xsl:variable name="rtfs" select=".//ui:textarea[ui:rtf]"/>
		<xsl:variable name="selectToggles" select=".//ui:selecttoggle|.//ui:rowselection[@selectAll]"/>
		<xsl:variable name="subordinates" select=".//ui:subordinate"/>
		<xsl:variable name="eagerness" select="//*[@mode eq 'eager']"/>
		<xsl:variable name="hasAjaxTriggers" select=".//ui:ajaxtrigger"/>
		<xsl:variable name="timeoutWarn" select=".//ui:session[1]"/>
		<xsl:variable name="editors" select=".//html:wc-imageedit"/>
		<xsl:variable name="tableActions" select=".//ui:table/ui:actions/ui:action"/>
		<xsl:if test="$componentGroups">
			<xsl:text>require(["wc/ui/subordinate"], function(c){c.registerGroups([</xsl:text>
			<xsl:apply-templates select="$componentGroups" mode="JS"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$tableActions">
			<xsl:text>require(["wc/ui/table/action"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$tableActions" mode="JS"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$editors">
			<xsl:text>require(["wc/ui/imageEdit"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$editors" mode="JS"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$dialogs">
			<xsl:text>require(["wc/ui/dialog"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$dialogs" mode="JS"/>
			<xsl:text>]</xsl:text>
			<xsl:if test="ancestor::ui:ajaxresponse">
				<xsl:text>,true</xsl:text>
			</xsl:if>
			<xsl:text>);});</xsl:text>
		</xsl:if>
		<xsl:if test="$dataListCombos">
			<xsl:text>require(["wc/ui/comboLoader"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$dataListCombos" mode="registerIds"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$dataListComponents">
			<xsl:text>require(["wc/ui/selectLoader"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$dataListComponents" mode="registerIds"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$filedrops">
			<xsl:text>require(["wc/ui/multiFileUploader"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$filedrops" mode="registerIds"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$multiDDData">
			<xsl:text>require(["wc/ui/multiFormComponent"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$multiDDData" mode="registerIds"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$popups">
			<xsl:text>require(["wc/ui/popup"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$popups" mode="JS"/>
			<xsl:text>])});</xsl:text>
		</xsl:if>
		<xsl:if test="$redirects">
			<xsl:text>require(["wc/ui/redirect"], function(c){c.register(</xsl:text>
			<xsl:apply-templates select="$redirects[1]" mode="JS"/>
			<xsl:text>);});</xsl:text>
		</xsl:if>
		<xsl:if test="$rtfs">
			<xsl:text>require(["wc/ui/rtf"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$rtfs" mode="registerIds"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$subordinates">
			<xsl:text>require(["wc/ui/subordinate","wc/ui/SubordinateAction"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$subordinates" mode="JS"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$timeoutWarn">
			<xsl:text>require(["wc/ui/timeoutWarn"], function(c){</xsl:text>
				<xsl:text>c.initTimer(</xsl:text>
				<xsl:value-of select="$timeoutWarn/@timeout" />
				<xsl:if test="$timeoutWarn/@warn">
					<xsl:text>,</xsl:text>
					<xsl:value-of select="$timeoutWarn/@warn" />
				</xsl:if>
			<xsl:text>);});</xsl:text>
		</xsl:if>
		<xsl:if test="$eagerness">
			<xsl:text>require(["wc/ui/containerload"], function(c){c.register([</xsl:text>
			<xsl:apply-templates select="$eagerness" mode="registerIds"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="$hasAjaxTriggers">
			<!--NOTE: if we have an ajaxTrigger we have to require the generic subscriber even if it is never used -->
			<xsl:text>require(["wc/ui/ajaxRegion","wc/ui/ajax/genericSubscriber"], function(c, s){c.register([</xsl:text>
			<xsl:apply-templates select="$hasAjaxTriggers" mode="JS"/>
			<xsl:text>]);});</xsl:text>
		</xsl:if>
		<xsl:if test="//@defaultFocusId">
			<xsl:text>require(["wc/ui/onloadFocusControl"], function(c){c.register("</xsl:text>
			<xsl:value-of select="//@defaultFocusId[1]"/>
			<xsl:text>");});</xsl:text>
		</xsl:if>
	</xsl:template>

	<!--
		Simple template for any component which requires a registration id list.
	-->
	<xsl:template match="*" mode="registerIds">
		<xsl:text>"</xsl:text>
		<xsl:choose>
			<xsl:when test="self::ui:tab">
				<xsl:value-of select="ui:tabcontent/@id"/>
			</xsl:when>
			<xsl:when test="self::ui:collapsible or self::ui:submenu">
				<xsl:value-of select="ui:content/@id"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@id"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>"</xsl:text>
		<xsl:if test="position() ne last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
