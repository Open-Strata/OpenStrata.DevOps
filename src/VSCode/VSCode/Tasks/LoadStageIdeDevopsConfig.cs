using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Xml.Linq;
using System.Xml.XPath;


namespace OpenStrata.Extension.IdeDevOps.MSBuild.tasks
{
    public class LoadStageIdeDevopsConfig : BaseTask
    {


        [Required]
        public string ConfigPath { get; set; }

        [Required]
        public string Stage { get; set; }

        [Output]
        public string Environment { get; set; }

        [Output]
        public string PacAuthName { get; set; }

        [Output]
        public string Cloud { get; set; }

        [Output]
        public string ApplicationId { get; set; }

        [Output]
        public string TenantId { get; set; }


        public override bool ExecuteTask()
        {
            var configFi = new FileInfo(ConfigPath);


            if (configFi.Exists)
            {
                var configDoc = XDocument.Load(configFi.FullName);

                var stageElement = configDoc.XPathSelectElement($"/IdeDevopsConfig/DevopsStage[@Name='{Stage}']");

                // <IdeDevopsConfig >
                // <DevopsStage Name="dev">
                //  <Environment></Environment>
                //  <PacAuthName></PacAuthName>
                //  <Cloud>Public</Cloud>
                //  <ApplicationId></ApplicationId>
                //  <TenantId></TenantId>
                //  </DevopsStage>
                //</IdeDevopsConfig>

                Environment = stageElement.Element("Environment")?.Value ?? "";
                PacAuthName = stageElement.Element("PacAuthName")?.Value ?? "";
                Cloud = stageElement.Element("Cloud")?.Value ?? "";
                ApplicationId = stageElement.Element("ApplicationId")?.Value ?? "";
                TenantId = stageElement.Element("TenantId")?.Value ?? "";

            }

            return true;
        }
    }
}
