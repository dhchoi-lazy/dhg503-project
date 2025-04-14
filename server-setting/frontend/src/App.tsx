import React, { useState, useCallback, ChangeEvent } from "react";
import "./App.css";
import { Button } from "./components/ui/button";
import { Input } from "./components/ui/input";
import { Label } from "./components/ui/label";
import { Textarea } from "./components/ui/textarea";
import { Card, CardContent, CardFooter } from "@/components/ui/card";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";

// Define the steps based on DESIGN.md
const steps = [
  "Welcome",
  "Connect to EC2",
  "Prepare System",
  "Setup Git User",
  "Configure SSH",
  "Manage SSH Keys",
  "Setup Repository",
  "Docker Setup",
  "Completed",
];

// Type for command results from backend
interface CommandResult {
  success: boolean;
  output: string;
  error: string;
}

// Define types
interface ConnectionDetails {
  url: string;
  username: string;
  pemPath: string; // Path on the local filesystem used by frontend/API call
  pem_path?: string; // Path received from backend config (optional, used for display)
}

// Define the API base URL (empty for same origin)
const API_BASE_URL = "http://localhost:8888";

function App() {
  const [currentStep, setCurrentStep] = useState(0);
  const [connectionDetails, setConnectionDetails] = useState<ConnectionDetails>(
    {
      url: localStorage.getItem("ec2Url") || "",
      username: localStorage.getItem("ec2Username") || "ubuntu", // Default to ubuntu
      pemPath: "", // This will be set by file upload/selection or loaded config
      pem_path: localStorage.getItem("ec2PemPathDisplay") || undefined, // Display path
    }
  );
  const [pemFilePath, setPemFilePath] = useState<string | null>( // Separate state for the actual file path used in connection
    localStorage.getItem("ec2PemPath") || null
  );
  // Added state
  // State for inputs needed in various steps
  const [stepInputs, setStepInputs] = useState({
    gitPassword: "",
    userEmail: "student@example.com", // Default email
    commitMessage: "Initial commit", // Default commit message
    dockerAction: "deploy", // Default docker action
  });
  const [isLoading, setIsLoading] = useState(false);
  const [stepStatus, setStepStatus] = useState<{
    [key: number]: "pending" | "success" | "error";
  }>({});
  // Store output/errors for each step
  const [stepOutputs, setStepOutputs] = useState<{ [key: number]: string }>({});
  const [error, setError] = useState<string | null>(null);
  const [stepInfoMessage, setStepInfoMessage] = useState<string | null>(null); // State for info messages
  const [isDragging, setIsDragging] = useState(false); // State for drag-over visual feedback
  const [gitUserStepAction, setGitUserStepAction] = useState<
    "overwrite" | "skip"
  >("overwrite"); // Default to overwrite

  const totalSteps = steps.length - 1;

  const handleInputChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    setStepInputs((prev) => ({ ...prev, [name]: value }));
  };

  const handleNext = () => {
    if (currentStep < totalSteps) {
      setCurrentStep(currentStep + 1);
      setError(null); // Clear errors on step change
      setStepInfoMessage(null); // Clear info message on step change
    }
  };

  const handlePrev = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
      setError(null); // Clear errors on step change
      setStepInfoMessage(null); // Clear info message on step change
      // Clear output of the step we are leaving? Optional.
      // setStepOutputs(prev => ({ ...prev, [currentStep]: undefined }));
    }
  };

  console.log(isLoading);

  // Function to handle the API call for connection (Step 1)
  const handleConnect = async () => {
    setIsLoading(true);
    setError(null);
    setStepOutputs({}); // Clear previous outputs when reconnecting
    console.log("Attempting to connect with:", connectionDetails);

    try {
      const response = await fetch(`${API_BASE_URL}/api/connect`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          url: connectionDetails.url,
          username: connectionDetails.username,
          pem_path: pemFilePath, // Use the actual pemFilePath state here
        }),
      });

      const result: { status: string; message: string } = await response.json();

      if (response.ok && result.status === "connected") {
        console.log("Connection successful:", result.message);
        setStepStatus({ [1]: "success" }); // Set specific step status
        setStepOutputs({ [1]: `Success: ${result.message}` });

        // Save connection details to localStorage on successful connection
        localStorage.setItem("ec2Url", connectionDetails.url);
        localStorage.setItem("ec2Username", connectionDetails.username);
        localStorage.setItem("ec2PemPath", pemFilePath || ""); // Save the actual path used
        localStorage.setItem(
          "ec2PemPathDisplay",
          connectionDetails.pem_path || ""
        ); // Save the display path

        handleNext();
      } else {
        console.error("Connection failed:", result.message || "Unknown error");
        setError(result.message || "Failed to connect.");
        setStepStatus({ ...stepStatus, [1]: "error" });
        setStepOutputs({
          [1]: `${result.message || "Error:  Failed to connect."}`,
        });
      }
    } catch (err: unknown) {
      console.error("API call failed:", err);
      const errorMsg = `Connection error: ${
        err instanceof Error ? err.message : String(err)
      }. Is the backend server running?`;
      setError(errorMsg);
      setStepStatus({ ...stepStatus, [1]: "error" });
      setStepOutputs({ [1]: `Error: ${errorMsg}` });
    }

    setIsLoading(false);
  };

  // Refactored core upload logic
  const uploadPemFile = useCallback(
    async (file: File) => {
      if (!file || !file.name.endsWith(".pem")) {
        setError("Invalid file type. Please upload a .pem file.");
        return;
      }

      setIsLoading(true);
      setError(null);
      const formData = new FormData();
      formData.append("key_file", file);

      try {
        const response = await fetch(`${API_BASE_URL}/api/upload-key`, {
          method: "POST",
          body: formData,
        });
        if (!response.ok) {
          const errorData = await response.json().catch(() => ({}));
          throw new Error(
            `Key upload failed: ${response.status} ${response.statusText} ${
              errorData.detail || ""
            }`
          );
        }
        const result = await response.json();
        if (result.status === "success" && result.file_path) {
          setPemFilePath(result.file_path);
          setConnectionDetails((prev) => ({ ...prev, pem_path: file.name })); // Update display path
          setError(null); // Clear any previous file error
        } else {
          throw new Error(
            result.message || "Key upload failed with unknown error"
          );
        }
      } catch (err: unknown) {
        console.error("Key upload error:", err);
        setError(
          `Key upload failed: ${
            err instanceof Error ? err.message : String(err)
          }`
        );
        // Clear potentially invalid state if upload fails
        // setPemFilePath(null);
        // setConnectionDetails(prev => ({ ...prev, pem_path: undefined }));
      } finally {
        setIsLoading(false);
        setIsDragging(false); // Ensure dragging state is reset
      }
    },
    [connectionDetails]
  ); // Removed dependency on connectionDetails as we now use setConnectionDetails(prev => ...)

  // Function to handle PEM file selection via input
  const handleKeyUpload = (event: ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      uploadPemFile(file);
    }
    // Reset file input to allow uploading the same file again if needed
    event.target.value = "";
  };

  // Drag and Drop Handlers
  const handleDragOver = useCallback(
    (event: React.DragEvent<HTMLDivElement>) => {
      event.preventDefault(); // Necessary to allow dropping
      event.stopPropagation();
      setIsDragging(true);
    },
    []
  );

  const handleDragLeave = useCallback(
    (event: React.DragEvent<HTMLDivElement>) => {
      event.preventDefault();
      event.stopPropagation();
      setIsDragging(false);
    },
    []
  );

  const handleDrop = useCallback(
    (event: React.DragEvent<HTMLDivElement>) => {
      event.preventDefault();
      event.stopPropagation();
      setIsDragging(false);

      if (event.dataTransfer.files && event.dataTransfer.files.length > 0) {
        const file = event.dataTransfer.files[0];
        uploadPemFile(file); // Use the refactored upload function
        event.dataTransfer.clearData();
      }
    },
    [uploadPemFile] // Depend on the memoized upload function
  );

  // Execute actions for Steps 2-7
  const executeStepAction = async (stepIndex: number) => {
    // ---> Move Skip Logic for Step 3 to the top <---
    if (stepIndex === 3 && gitUserStepAction === "skip") {
      console.log("Skipping Step 3: Git User Setup");
      setError(null); // Clear errors
      setStepInfoMessage("Git User Setup skipped."); // Set info message
      setStepOutputs((prev) => ({
        ...prev,
        [stepIndex]: "Skipped Git User Setup as requested.", // Set output
      }));
      setStepStatus((prev) => ({ ...prev, [stepIndex]: "success" })); // Set success status
      // No need to set isLoading true/false here as we return immediately
      return; // Exit the function
    }
    // ---> End Skip Logic <---

    // Set loading state only if NOT skipping
    setIsLoading(true);
    setError(null);
    setStepInfoMessage(null);
    setStepOutputs((prev) => ({ ...prev, [stepIndex]: "Running..." }));

    let url = "";
    const options: RequestInit = { method: "POST", headers: {} };
    let stepSuccess = false;
    let outputLog = "";

    try {
      switch (stepIndex) {
        case 2: // Prepare System
          url = `${API_BASE_URL}/api/system-preparation`;
          break;
        case 3: // Setup Git User (Overwrite Action)
          // This case is now only reached if gitUserStepAction is 'overwrite'
          url = `${API_BASE_URL}/api/git-user-setup`;

          // Added block scope for lexical declaration
          {
            // Validate password presence for overwrite action
            if (!stepInputs.gitPassword) {
              throw new Error(
                "Password cannot be empty when choosing 'Create / Overwrite Git User'."
              );
            }

            const gitPassFormData = new FormData();
            gitPassFormData.append("password", stepInputs.gitPassword);
            options.body = gitPassFormData;

            // *** Explicitly delete Content-Type header for FormData ***
            // Cast headers to Record<string, string> to allow deletion by key
            if (options.headers) {
              // Add a check to satisfy potential undefined warning
              delete (options.headers as Record<string, string>)[
                "Content-Type"
              ];
            }
          }
          break;
        case 4: // Configure SSH
          url = `${API_BASE_URL}/api/ssh-configuration`;
          break;
        case 5: // Manage SSH Keys
          url = `${API_BASE_URL}/api/ssh-key-management`;
          // Set JSON header for this specific request
          options.headers = { "Content-Type": "application/json" };
          options.body = JSON.stringify({ email: stepInputs.userEmail });
          break;
        case 6: // Setup Repository
          url = `${API_BASE_URL}/api/repository-setup`;
          break;
        case 7: // Docker Setup
          url = `${API_BASE_URL}/api/docker-setup`;
          break;
        default:
          throw new Error("Invalid step index for action execution");
      }

      if (!url) {
        throw new Error("API URL not defined for this step.");
      }

      // --- Fetch API ---
      const response = await fetch(url, options);
      const result: unknown = await response.json();

      console.log(`Step ${stepIndex} raw result:`, result); // Log raw result

      // --- START: Refined Result Processing ---
      let processingError: string | null = null;
      stepSuccess = false; // Default to false

      // Define the expected structure for the formatted result helper
      interface FormattedResult {
        log: string;
        isIgnoredError: boolean;
        isSuccess: boolean;
      }

      // Helper to format individual command results for the log
      const formatCommandResult = (
        cmdName: string,
        res: CommandResult,
        stepIdx: number
      ): FormattedResult => {
        let status = res.success ? "Success" : "Failed";
        let isIgnoredError = false;
        // Special handling for step 3 userdel error
        if (
          stepIdx === 3 &&
          cmdName === "remove_result" &&
          !res.success &&
          res.error?.includes("mail spool")
        ) {
          status = "Warning (Ignored Mail Spool Error)";
          isIgnoredError = true;
        }
        return {
          log: `--- Command: ${cmdName} [${status}] ---\nOutput: ${
            res.output || "(none)"
          }\nError: ${res.error || "(none)"}`,
          isIgnoredError: isIgnoredError,
          isSuccess: res.success || isIgnoredError, // Treat ignored error as success for overall check
        };
      };

      // --- Type Check ---
      // Check if result is an object and not null before accessing properties
      if (typeof result === "object" && result !== null) {
        // Check specific structures after the basic object check
        if (
          stepIndex === 3 &&
          "remove_result" in result &&
          "user_result" in result &&
          "sudo_result" in result &&
          "password_result" in result
        ) {
          // Special handling for Git User Setup
          // Define the structure for the Step 3 results map
          interface Step3ResultsMap {
            remove_result: CommandResult;
            user_result: CommandResult;
            sudo_result: CommandResult;
            password_result: CommandResult;
          }
          const resultsMap: Step3ResultsMap = {
            remove_result: result.remove_result as CommandResult,
            user_result: result.user_result as CommandResult,
            sudo_result: result.sudo_result as CommandResult,
            password_result: result.password_result as CommandResult,
          };

          const formattedResults: FormattedResult[] = Object.entries(
            resultsMap
          ).map(([name, res]) => formatCommandResult(name, res, stepIndex));

          outputLog = formattedResults
            .map((fr: FormattedResult) => fr.log)
            .join("\n\n");

          // Overall step success requires all individual commands to succeed (or have ignored errors)
          stepSuccess = formattedResults.every(
            (fr: FormattedResult) => fr.isSuccess
          );

          if (!stepSuccess) {
            // Find the first command that failed (and wasn't ignored)
            const firstFailure = formattedResults.find(
              (fr: FormattedResult) => !fr.isSuccess
            );
            // Extract command name safely from the log string
            const failedCommandName =
              firstFailure?.log.match(/Command: (\w+)/)?.[1];
            const failedCommandResult = failedCommandName
              ? resultsMap[failedCommandName as keyof Step3ResultsMap]
              : null;
            processingError =
              failedCommandResult?.error ||
              "Git user setup failed with an unknown error.";
          }
        } else if ("results" in result && Array.isArray(result.results)) {
          // Handle endpoints that return {"results": [...]}
          const commandResults = result.results as CommandResult[];
          const formattedResults: FormattedResult[] = commandResults.map(
            (r: CommandResult, i: number) =>
              formatCommandResult(`Command ${i + 1}`, r, stepIndex)
          );
          outputLog = formattedResults
            .map((fr: FormattedResult) => fr.log)
            .join("\n\n");
          stepSuccess = formattedResults.every(
            (fr: FormattedResult) => fr.isSuccess
          );
          if (!stepSuccess) {
            const firstFailure = commandResults.find(
              (r: CommandResult) => !r.success
            );
            processingError =
              firstFailure?.error || "Unknown error in multi-step command.";
          }

          // ---> Specific handling for Step 2 Skip Message <-----
          if (
            stepIndex === 2 &&
            "skipped" in result && // Add check for 'skipped' property
            result.skipped === true &&
            stepSuccess
          ) {
            // If step 2 was skipped successfully, set the info message from the result
            setStepInfoMessage(
              commandResults[0]?.output ||
                "System preparation skipped (already up-to-date)."
            );
          }
          // ---> End Specific handling <-----
        } else if ("success" in result) {
          // Replaced hasOwnProperty with 'in' operator after typeof check
          // Handle endpoints returning a single result object {success, output, error}
          const formattedResult: FormattedResult = formatCommandResult(
            "Single Command",
            result as CommandResult, // Assert as CommandResult after 'success' check
            stepIndex
          );
          outputLog = formattedResult.log;
          stepSuccess = formattedResult.isSuccess;
          if (!stepSuccess) {
            processingError =
              (result as CommandResult).error ||
              "Step failed with unknown error."; // Added type assertion
          }
        } else {
          // Fallback for unexpected structures
          stepSuccess = false;
          outputLog = `Unexpected Response Structure:\n${JSON.stringify(
            result,
            null,
            2
          )}`;
          processingError =
            (result as { message?: string }).message ||
            "Step failed with unexpected response structure."; // Added type assertion
        }
      } else {
        // Handle cases where result is not an object (e.g., null, primitive)
        stepSuccess = false;
        outputLog = `Unexpected Response Type: ${typeof result}`;
        processingError =
          "Step failed due to unexpected response type from server.";
      }
      // --- END: Refined Result Processing ---

      setStepOutputs((prev) => ({ ...prev, [stepIndex]: outputLog }));

      if (stepSuccess) {
        console.log(`Step ${steps[stepIndex]} successful`);
        setStepStatus((prev) => ({ ...prev, [stepIndex]: "success" }));
        setError(null); // Clear any previous error on success

        // Set info message if not already set by skip logic
        if (!stepInfoMessage) {
          setStepInfoMessage(
            `Step '${steps[stepIndex]}' completed successfully.`
          );
        }
      } else {
        console.error(`Step ${steps[stepIndex]} failed`);
        setStepStatus((prev) => ({ ...prev, [stepIndex]: "error" }));
        setError(processingError || "An unknown error occurred."); // Set the specific error message
      }
    } catch (err: unknown) {
      console.error("API call failed:", err);
      const errorMsg = `Action error: ${
        err instanceof Error ? err.message : String(err)
      }. Check console or backend logs.`;
      setError(errorMsg);
      setStepStatus((prev) => ({ ...prev, [stepIndex]: "error" }));
      setStepOutputs((prev) => ({
        ...prev,
        [stepIndex]: `Error: ${errorMsg}`,
      }));
      // Note: stepSuccess remains false from initialization
    } finally {
      // Ensure isLoading is always turned off after try/catch completes
      setIsLoading(false);
    }
  };

  // Render content based on current step
  const renderStepContent = () => {
    const outputContent = stepOutputs[currentStep] || "";
    const isStepSuccessful = stepStatus[currentStep] === "success";

    // Base component for steps 2-7
    const renderActionStep = (
      title: string,
      description: string,
      inputFields?: React.ReactNode
    ) => (
      <div>
        <h2 className="text-2xl font-semibold mb-4">{title}</h2>
        <p className="mb-4">{description}</p>

        {/* Display Step Info Message if available */}
        {stepInfoMessage && (
          <div className="mb-4 p-3 bg-blue-100 border border-blue-400 text-blue-700 rounded">
            <p>{stepInfoMessage}</p>
          </div>
        )}

        {inputFields}
        <div className="flex justify-end mt-4">
          <Button
            onClick={() => executeStepAction(currentStep)}
            disabled={isLoading || isStepSuccessful}
            variant="outline"
            className={`
              border-2 border-solid border-primary
              ${
                isStepSuccessful
                  ? "bg-green-500 hover:bg-green-600 text-white border-green-600"
                  : "hover:bg-primary/90"
              }
            `}
          >
            {isLoading
              ? "Running..."
              : isStepSuccessful
              ? "Completed Successfully"
              : `Execute ${steps[currentStep]}`}
          </Button>
        </div>
        {/* Output Area */}
        {outputContent && (
          <div className="mt-6">
            <Label>Output / Log</Label>
            <Textarea
              readOnly
              value={outputContent}
              className="mt-2 h-40 font-mono text-sm bg-gray-50"
              placeholder="Command output will appear here..."
            />
          </div>
        )}
      </div>
    );

    switch (currentStep) {
      case 0: // Welcome
        return (
          <div>
            <h2 className="text-2xl font-semibold mb-4">
              Welcome to the AWS EC2 Repository Manager
            </h2>
            <p className="mb-4">
              This tool helps you set up an EC2 instance for Git repository
              hosting step-by-step. Ensure the backend server is running.
            </p>
            <p>Click "Next" to begin.</p>
          </div>
        );
      case 1: // Connect to EC2
        return (
          <Card>
            <CardContent>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="ec2-url" className="text-right">
                  EC2 URL/IP
                </Label>
                <Input
                  id="ec2-url"
                  value={connectionDetails.url}
                  onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                    setConnectionDetails({
                      ...connectionDetails,
                      url: e.target.value,
                    })
                  }
                  placeholder="e.g., ec2-xx-xx-xx-xx.compute-1.amazonaws.com or IP address"
                  className="col-span-3"
                  disabled={isLoading || isStepSuccessful}
                />
              </div>
              <div className="grid grid-cols-4 items-center gap-4 mt-4">
                <Label htmlFor="ec2-username" className="text-right">
                  Username
                </Label>
                <Input
                  id="ec2-username"
                  value={connectionDetails.username}
                  onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                    setConnectionDetails({
                      ...connectionDetails,
                      username: e.target.value,
                    })
                  }
                  placeholder="e.g., ubuntu, ec2-user"
                  className="col-span-3"
                  disabled={isLoading || isStepSuccessful}
                />
              </div>
              <div
                className={`grid grid-cols-4 items-center gap-4 mt-4 border-2 border-dashed rounded-lg p-4 transition-colors ${
                  isDragging ? "border-primary bg-muted/50" : "border-border"
                }`}
                onDragOver={handleDragOver}
                onDragLeave={handleDragLeave}
                onDrop={handleDrop}
              >
                <Label htmlFor="pem-key-upload" className="text-right">
                  PEM Key File
                </Label>
                <div className="col-span-3 flex flex-col items-center justify-center text-center">
                  <Input
                    id="pem-key-upload"
                    type="file"
                    accept=".pem"
                    onChange={handleKeyUpload} // Use the dedicated upload handler
                    placeholder="~/.ssh/dhg503.pem"
                    className="hidden" // Hide the default input visually, but keep for accessibility/fallback
                    disabled={isLoading || isStepSuccessful}
                  />
                  {/* Make the label clickable to trigger the hidden input */}
                  <Label
                    htmlFor="pem-key-upload"
                    className="cursor-pointer text-primary hover:underline mb-2"
                  >
                    Click to browse or drag & drop your .pem file here
                  </Label>
                  {/* Display the absolute path from pemFilePath state if available */}
                  {pemFilePath && (
                    <span
                      className="text-sm text-muted-foreground truncate"
                      title={pemFilePath} // Show full path on hover
                    >
                      Using key: {pemFilePath} {/* Display the absolute path */}
                    </span>
                  )}
                  {/* Show placeholder text only if no file path is set */}
                  {!pemFilePath && (
                    <span className="text-sm text-muted-foreground">
                      (e.g., ~/.ssh/your-key.pem)
                    </span>
                  )}
                </div>
              </div>
            </CardContent>
            <CardFooter className="flex justify-between">
              <Button
                variant="outline"
                onClick={handlePrev}
                disabled={isLoading}
              >
                Back
              </Button>
              <Button
                onClick={handleConnect} // Use handleConnect which calls executeStep
                variant="outline"
                disabled={
                  isLoading ||
                  !connectionDetails.url ||
                  !connectionDetails.username ||
                  !pemFilePath || // Disable if no pemFilePath is set
                  isStepSuccessful // Prevent re-connecting if already successful this session
                }
              >
                {isLoading ? "Connecting..." : "Connect & Save"}
              </Button>
            </CardFooter>
          </Card>
        );

      case 2: // Prepare System
        return renderActionStep(
          `Step ${currentStep}: ${steps[currentStep]}`,
          "Updates package lists, upgrades installed packages, and installs Git on the EC2 instance."
        );

      case 3: // Setup Git User
        return renderActionStep(
          `Step ${currentStep}: ${steps[currentStep]}`,
          "Choose whether to create/overwrite the 'git' user with a new password or skip this step if the user is already configured.",
          <>
            <RadioGroup
              value={gitUserStepAction}
              onValueChange={(value: "overwrite" | "skip") =>
                setGitUserStepAction(value)
              }
              className="mb-4 space-y-3"
              disabled={isLoading || isStepSuccessful}
            >
              {/* Option 1: Overwrite */}
              <div className="flex items-center space-x-3 p-2 border rounded hover:bg-muted/50 transition-colors">
                <RadioGroupItem value="overwrite" id="r1" className="h-5 w-5" />
                <Label
                  htmlFor="r1"
                  className="text-base font-medium cursor-pointer"
                >
                  Create / Overwrite Git User
                  <p className="text-sm text-muted-foreground font-normal">
                    This will remove the existing 'git' user (if any) and create
                    a new one with the password you provide below.
                  </p>
                </Label>
              </div>
              {/* Option 2: Skip */}
              <div className="flex items-center space-x-3 p-2 border rounded hover:bg-muted/50 transition-colors">
                <RadioGroupItem value="skip" id="r2" className="h-5 w-5" />
                <Label
                  htmlFor="r2"
                  className="text-base font-medium cursor-pointer"
                >
                  Skip Git User Setup
                  <p className="text-sm text-muted-foreground font-normal">
                    Select this if the 'git' user is already configured
                    correctly on the EC2 instance.
                  </p>
                </Label>
              </div>
            </RadioGroup>

            {gitUserStepAction === "overwrite" && (
              <div className="grid grid-cols-4 items-center gap-4 mt-6">
                <Label htmlFor="gitPassword" className="text-right text-base">
                  Git User Password
                </Label>
                <Input
                  id="gitPassword"
                  name="gitPassword"
                  type="password"
                  value={stepInputs.gitPassword}
                  onChange={handleInputChange}
                  className="col-span-3"
                  placeholder="Enter a strong password for the 'git' user"
                  disabled={isLoading || isStepSuccessful}
                />
              </div>
            )}
          </>
        );

      case 4: // Configure SSH
        return renderActionStep(
          `Step ${currentStep}: ${steps[currentStep]}`,
          "Creates the .ssh directory for the 'git' user and sets appropriate permissions for authorized_keys."
        );

      case 5: // Manage SSH Keys
        return renderActionStep(
          `Step ${currentStep}: ${steps[currentStep]}`,
          "Copies the SSH public key of the main user (e.g., 'ubuntu') to the 'git' user's authorized_keys file, allowing passwordless access for the main user to the git user."
        );

      case 6: // Setup Repository
        return renderActionStep(
          `Step ${currentStep}: ${steps[currentStep]}`,
          "Creates the repository directory, sets ownership to the 'git' user, and initializes a bare Git repository."
        );

      case 7: // Docker Setup (New Step 7)
        return renderActionStep(
          `Step ${currentStep}: ${steps[currentStep]}`,
          "Installs Docker Engine, Docker Compose, adds the user to the docker group, and configures necessary repositories."
          // No input fields needed for this step based on DESIGN.md
        );

      case 8: // Completed (Now Step 8)
        return (
          <div>
            <h2 className="text-2xl font-semibold mb-4">Setup Complete!</h2>
            <p>Your EC2 instance and Git repository should be configured.</p>
            <p>
              Review the output logs for each step to ensure everything ran
              correctly.
            </p>
            <p className="mt-4">
              You can now manage your repository and Docker containers using
              standard Git and Docker commands or the 'Manage Docker' step
              above.
            </p>
          </div>
        );
      default:
        return <div>Unknown Step</div>;
    }
  };

  // Basic progress indicator
  const progressPercentage = Math.min(
    100,
    (currentStep / (totalSteps - 1)) * 100
  ); // Calculate progress excluding "Completed" step

  return (
    <div className="min-h-screen bg-gray-100 flex items-center justify-center p-4">
      <div className="bg-white shadow-xl rounded-lg p-8 w-full max-w-3xl">
        {" "}
        {/* Increased max-width */}
        <h1 className="text-3xl font-bold text-center mb-6">
          EC2 Repository Setup Wizard
        </h1>
        {/* Progress Bar */}
        {currentStep < totalSteps && ( // Hide progress bar on completed step
          <div className="mb-6">
            <div className="relative pt-1">
              <div className="flex mb-2 items-center justify-between">
                <div>
                  <span className="text-xs font-semibold inline-block py-1 px-2 uppercase rounded-full text-blue-600 bg-blue-200">
                    Step {currentStep + 1} of {totalSteps}
                  </span>
                </div>
                <div className="text-right">
                  <span className="text-xs font-semibold inline-block text-blue-600">
                    {Math.round(progressPercentage)}%
                  </span>
                </div>
              </div>
              <div className="overflow-hidden h-2 mb-4 text-xs flex rounded bg-blue-200">
                <div
                  style={{ width: `${progressPercentage}%` }}
                  className="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-blue-500 transition-all duration-500"
                ></div>
              </div>
              <p className="text-center text-sm font-medium text-gray-700">
                {steps[currentStep]}
              </p>
            </div>
          </div>
        )}
        {/* Step Content */}
        <div className="mb-6 min-h-[300px]">{renderStepContent()}</div>{" "}
        {/* Increased min-height */}
        {/* Error Display */}
        {error && (
          <div className="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded">
            <p>
              <strong>Error:</strong> {error}
            </p>
          </div>
        )}
        {/* Navigation Buttons */}
        <div className="flex justify-between items-center border-t pt-4 mt-6">
          <Button
            variant="outline"
            onClick={handlePrev}
            disabled={currentStep === 0 || isLoading}
          >
            Previous
          </Button>
          {/* Conditionally render Next/Finish buttons */}
          {/* Next button shown for Welcome step */}
          {currentStep === 0 && (
            <Button variant="outline" onClick={handleNext} disabled={isLoading}>
              Next
            </Button>
          )}
          {/* Next button shown for steps 1-7 AFTER the step action is successful */}
          {currentStep > 0 &&
            currentStep < totalSteps &&
            stepStatus[currentStep] === "success" && (
              <Button
                variant="outline"
                onClick={handleNext}
                disabled={isLoading} // Should not be loading if step succeeded
              >
                {/* Show Finish on the last action step (index 7) */}
                {currentStep === totalSteps - 1 ? "Finish" : "Next"}
              </Button>
            )}
        </div>
      </div>
    </div>
  );
}

export default App;
