from flask import Flask, request, jsonify
import google.generativeai as genai
import os

app = Flask(__name__)

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

model = genai.GenerativeModel("gemini-1.5-flash")

@app.route("/grade", methods=["POST"])
def grade():
    data = request.get_json()
    
    question = data.get("question", "")
    student_answer = data.get("answer", "")

    prompt = f"""
You are an automatic coding grader.

Problem:
{question}

Student's Code Submission:
{student_answer}

Decide if the answer is correct.
Respond ONLY in valid JSON, with:
- "correct": true or false
- "feedback": brief message for the student
"""

    try:
        response = model.generate_content(prompt)
        text = response.text.strip()
    
        import json
        data = json.loads(text)

        return jsonify(data)
    except Exception as e:
        print("Grading error:", e)
        return jsonify({"correct": False, "feedback": "Grading failed"}), 500

if __name__ == "__main__":
    app.run(port=5000)
