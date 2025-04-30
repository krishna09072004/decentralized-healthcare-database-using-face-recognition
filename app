// Add these functions to app.js

async function captureFace() {
    try {
      const response = await fetch('http://localhost:5000/capture-face');
      const data = await response.json();
      
      if (data.success) {
        capturedFaceDataHash = data.faceDataHash;
        capturedFaceData = data.faceData;
        return true;
      } else {
        alert("Failed to capture face: " + data.message);
        return false;
      }
    } catch (error) {
      console.error("Error capturing face:", error);
      alert("Error capturing face");
      return false;
    }
  }
  
  // Replace simulateCaptureFace with:
  async function handleCaptureFace(mode) {
    const success = await captureFace();
    
    if (success) {
      if (mode === 'register') {
        document.getElementById('register-btn').disabled = false;
        document.getElementById('register-status').innerHTML = "Face captured successfully! Click 'Register on Blockchain' to continue.";
        document.getElementById('register-status').style.display = 'block';
        document.getElementById('register-status').className = 'alert alert-info mt-3';
      } else {
        document.getElementById('verify-btn').disabled = false;
        document.getElementById('verify-status').innerHTML = "Face captured successfully! Click 'Verify Identity' to continue.";
        document.getElementById('verify-status').style.display = 'block';
        document.getElementById('verify-status').className = 'alert alert-info mt-3';
      }
    }
  }
  
  // Update capture button event listeners:
  document.getElementById('capture-btn').addEventListener('click', () => {
    handleCaptureFace('register');
  });
  
  document.getElementById('verify-capture-btn').addEventListener('click', () => {
    handleCaptureFace('verify');
  });
