<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xccdf="http://checklists.nist.gov/xccdf/1.1" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:dc="http://purl.org/dc/elements/1.1/">

<!-- This transform assembles all fragments into one "shorthand" XCCDF document
     Accepts the following parameters:

     * SHARED_RP	(required)	Holds the resolved ABSOLUTE path
					to the SSG's "shared/" directory.
-->

<!-- Define the default value of the required "SHARED_RP" parameter -->
<xsl:param name="SHARED_RP" select='undef' />


  <xsl:template match="Benchmark">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />

       <!-- Adding profiles here -->
       <xsl:apply-templates select="document('profiles/stig-openstack.xml')" />

       <!-- Adding 'conditional_clause' placeholder <xccdf:Value> here -->
       <Value id="conditional_clause" type="string" operator="equals">
         <title>A conditional clause for check statements.</title>
         <description>A conditional clause for check statements.</description>
         <value>This is a placeholder.</value>
       </Value>

      <!-- Adding remediation functions from concat($SHARED_RP, '/xccdf/remediation_functions.xml')
           location here -->
      <xsl:if test=" string($SHARED_RP) != 'undef' ">
        <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/remediation_functions.xml'))" />
      </xsl:if>

      <xsl:apply-templates select="document('intro/intro.xml')" />
      <xsl:apply-templates select="document('xccdf/services/services.xml')" />
      <!-- the auxiliary Groups here will be removed prior to some outputs -->
      <xsl:apply-templates select="document('auxiliary/nist_support.xml')" />
    </xsl:copy>
  </xsl:template>
<!-- 
  <xsl:template match="Group[@id='system']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/system/software/software.xml')" /> 
      <xsl:apply-templates select="document('xccdf/system/permissions/permissions.xml')" />
      <xsl:apply-templates select="document('xccdf/system/selinux.xml')" />
      <xsl:apply-templates select="document('xccdf/system/accounts/accounts.xml')" />
      <xsl:apply-templates select="document('xccdf/system/network/network.xml')" />
      <xsl:apply-templates select="document('xccdf/system/logging.xml')" />
      <xsl:apply-templates select="document('xccdf/system/auditing.xml')" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='software']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/system/software/disk_partitioning.xml')" />
      <xsl:apply-templates select="document('xccdf/system/software/updating.xml')" />
      <xsl:apply-templates select="document('xccdf/system/software/integrity.xml')" />
    </xsl:copy>
  </xsl:template>


  <xsl:template match="Group[@id='accounts']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/restrictions.xml')" />
      <xsl:apply-templates select="document('xccdf/system/accounts/pam.xml')" />
      <xsl:apply-templates select="document('xccdf/system/accounts/session.xml')" />
      <xsl:apply-templates select="document('xccdf/system/accounts/physical.xml')" />
      <xsl:apply-templates select="document('xccdf/system/accounts/banners.xml')" />
    </xsl:copy>
  </xsl:template>


  <xsl:template match="Group[@id='accounts-restrictions']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/root_logins.xml')" />
      <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/password_storage.xml')" /> 
      <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/password_expiration.xml')" />
      <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/account_expiration.xml')" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='permissions']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/system/permissions/partitions.xml')" />
      <xsl:apply-templates select="document('xccdf/system/permissions/mounting.xml')" />
      <xsl:apply-templates select="document('xccdf/system/permissions/files.xml')" />
      <xsl:apply-templates select="document('xccdf/system/permissions/execution.xml')" /> 
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='network']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/system/network/kernel.xml')" />
      <xsl:apply-templates select="document('xccdf/system/network/wireless.xml')" />
      <xsl:apply-templates select="document('xccdf/system/network/ipv6.xml')" />
      <xsl:apply-templates select="document('xccdf/system/network/firewalld.xml')" />
      <xsl:apply-templates select="document('xccdf/system/network/ssl.xml')" />
      <xsl:apply-templates select="document('xccdf/system/network/uncommon.xml')" />
      <xsl:apply-templates select="document('xccdf/system/network/ipsec.xml')" />
    </xsl:copy>
  </xsl:template>
-->
  <xsl:template match="Group[@id='services']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/services/horizon.xml')" />
      <xsl:apply-templates select="document('xccdf/services/cinder.xml')" />
      <xsl:apply-templates select="document('xccdf/services/keystone.xml')" />
      <xsl:apply-templates select="document('xccdf/services/neutron.xml')" />
      <xsl:apply-templates select="document('xccdf/services/nova.xml')" />
    </xsl:copy>
  </xsl:template>

  <!-- copy everything else through to final output -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

