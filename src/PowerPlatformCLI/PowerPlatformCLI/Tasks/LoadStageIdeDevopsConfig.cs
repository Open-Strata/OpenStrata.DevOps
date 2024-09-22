using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Text.Json.Nodes;
using System.ComponentModel.Design;


namespace OpenStrata.Devops.PowerPlatformCLI.tasks
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

                var envJson = JsonNode.Parse(File.ReadAllText(configFi.FullName));

                var stages = envJson?["devops"]?["stages"].AsArray();


                foreach (var stage in stages)
                {
                    if (((string)stage["stage"])?.ToLower() == Stage.ToLower())
                    {

                        var authSettings = stage?["authSettings"];

                        if (authSettings != null)
                        {

                            Environment = (string)authSettings?["environment"] ?? "";
                            PacAuthName = (string)authSettings?["authName"] ?? "";
                            Cloud = (string)authSettings?["cloud"] ?? "";
                            ApplicationId = (string)authSettings?["applicationId"] ?? "";
                            TenantId = (string)authSettings?["tenant"] ?? "";

                            return true;
                        }
                        return TaskFinishedWithWarning($"The {Stage} stage in {ConfigPath} does not contain an authSettings property");
                    }
                }

                return TaskFinishedWithWarning($"{ConfigPath} does not contain an entry for the stage: {Stage}.");


            }
            else {

                return TaskFinishedWithWarning($"{ConfigPath} does not exist.");

                // <IdeDevopsConfig >
                // <DevopsStage Name="dev">
                //  <Environment></Environment>
                //  <PacAuthName></PacAuthName>
                //  <Cloud>Public</Cloud>
                //  <ApplicationId></ApplicationId>
                //  <TenantId></TenantId>
                //  </DevopsStage>
                //</IdeDevopsConfig>

            }

        }
    }
}
