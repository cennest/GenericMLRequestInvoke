<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="ML.Azure" generation="1" functional="0" release="0" Id="66c2715f-8265-4817-9f89-7b64aef98eb0" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="ML.AzureGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="ML:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/ML.Azure/ML.AzureGroup/LB:ML:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="ML:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/ML.Azure/ML.AzureGroup/MapML:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="MLInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/ML.Azure/ML.AzureGroup/MapMLInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:ML:Endpoint1">
          <toPorts>
            <inPortMoniker name="/ML.Azure/ML.AzureGroup/ML/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapML:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/ML.Azure/ML.AzureGroup/ML/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapMLInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/ML.Azure/ML.AzureGroup/MLInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="ML" generation="1" functional="0" release="0" software="D:\Poulomee\Projects\MachineLearning\MLFromGit\ML\ML.Azure\csx\Debug\roles\ML" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;ML&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;ML&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/ML.Azure/ML.AzureGroup/MLInstances" />
            <sCSPolicyUpdateDomainMoniker name="/ML.Azure/ML.AzureGroup/MLUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/ML.Azure/ML.AzureGroup/MLFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="MLUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="MLFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="MLInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="7e0c747d-11d1-4ef6-9853-a8d0c6c63cf8" ref="Microsoft.RedDog.Contract\ServiceContract\ML.AzureContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="c5294169-b6c5-424d-8423-221285c89672" ref="Microsoft.RedDog.Contract\Interface\ML:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/ML.Azure/ML.AzureGroup/ML:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>