
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Prueba de Vocabulario</title>
    <style>
        body {
            background-color: #add8e6; /* Fondo azul */
            font-family: 'Times New Roman', Times, serif, sans-serif;
            text-align: center;
            padding: 50px;
            margin: 0;
        }
        #app {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            display: inline-block;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            margin-bottom: 20px;
        }
        #word {
            font-size: 1.5em;
            margin-bottom: 20px;
        }
        input[type="text"] {
            width: 80%;
            padding: 10px;
            font-size: 1em;
            margin-bottom: 20px;
        }
        button {
            padding: 10px 20px;
            font-size: 1em;
            margin: 5px;
            cursor: pointer;
        }
        #feedback {
            font-size: 1.2em;
            margin-bottom: 20px;
        }
        .correct {
            color: green;
        }
        .incorrect {
            color: red;
        }
        #score {
            font-size: 1.2em;
            margin-bottom: 20px;
        }
        #final-message {
            font-size: 1.5em;
            font-weight: bold;
            margin-top: 20px;
        }
        #restart-btn {
            display: none;
            padding: 10px 20px;
            font-size: 1em;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div id="app">
    <h1>Prueba de Vocabulario</h1>
    <div id="instructions">
        Traduce la siguiente palabra:
    </div>
    <div id="word"></div>
    <input type="text" id="answer" placeholder="Escribe tu respuesta aquí" autocomplete="off">
    <div id="feedback"></div>
    <button id="submit-btn">Enviar</button>
    <div id="score"></div>
    <div id="final-message"></div>
    <button id="restart-btn" onclick="restart()">Reiniciar Prueba</button>
</div>

<script>
    const wordPairs = [
        { english: 'Hello', spanish: 'Hola' },
        { english: 'Dog', spanish: 'Perro' },
        { english: 'House', spanish: 'Casa' },
        { english: 'Book', spanish: 'Libro' },
        { english: 'Computer', spanish: 'Computadora' },
        { english: 'Water', spanish: 'Agua' },
        { english: 'Sun', spanish: 'Sol' },
        { english: 'Moon', spanish: 'Luna' },
        { english: 'Food', spanish: 'Comida' },
        { english: 'Music', spanish: 'Música' },
    ];

    let currentIndex = 0;
    let correctAnswers = 0;
    let mistakes = 0;
    let testOver = false;

    const totalQuestions = 10;
    const passingScore = 8;

    const wordElement = document.getElementById('word');
    const answerInput = document.getElementById('answer');
    const feedbackElement = document.getElementById('feedback');
    const scoreElement = document.getElementById('score');
    const submitButton = document.getElementById('submit-btn');
    const finalMessageElement = document.getElementById('final-message');
    const restartButton = document.getElementById('restart-btn');

    function shuffle(array) {
        array.sort(() => Math.random() - 0.5);
    }

    function startTest() {
        shuffle(wordPairs);
        currentIndex = 0;
        correctAnswers = 0;
        mistakes = 0;
        testOver = false;
        finalMessageElement.innerText = '';
        restartButton.style.display = 'none';
        updateScore();
        showNextWord();
    }

    function updateScore() {
        scoreElement.innerText = `Preguntas: ${currentIndex}/${totalQuestions} | Correctas: ${correctAnswers} | Errores: ${mistakes}`;
    }

    function showNextWord() {
        if (currentIndex < totalQuestions && mistakes < 2) {
            const currentWordPair = wordPairs[currentIndex];
            const showInEnglish = Math.random() < 0.5;

            if (showInEnglish) {
                wordElement.innerText = currentWordPair.english;
                wordElement.dataset.correctAnswer = currentWordPair.spanish.toLowerCase();
            } else {
                wordElement.innerText = currentWordPair.spanish;
                wordElement.dataset.correctAnswer = currentWordPair.english.toLowerCase();
            }

            answerInput.value = '';
            answerInput.disabled = false;
            feedbackElement.innerText = '';
            answerInput.focus();
        } else {
            endTest();
        }
    }

    function checkAnswer() {
        if (testOver) return;

        const userAnswer = answerInput.value.trim().toLowerCase();
        const correctAnswer = wordElement.dataset.correctAnswer;

        if (userAnswer === '') {
            feedbackElement.innerText = 'Por favor, ingresa una respuesta.';
            return;
        }

        if (userAnswer === correctAnswer) {
            feedbackElement.innerHTML = '<span class="correct">¡Correcto!</span>';
            correctAnswers++;
        } else {
            feedbackElement.innerHTML = `<span class="incorrect">Incorrecto. La respuesta correcta era "${correctAnswer}".</span>`;
            mistakes++;
        }

        answerInput.disabled = true;
        currentIndex++;
        updateScore();

        if (mistakes >= 2) {
            endTest();
        } else {
            setTimeout(showNextWord, 1500);
        }
    }

    function endTest() {
        testOver = true;
        submitButton.disabled = true;
        answerInput.disabled = true;

        if (correctAnswers >= passingScore && mistakes < 2) {
            finalMessageElement.innerHTML = '<span class="correct">¡Felicidades, has aprobado la prueba!</span>';
        } else {
            finalMessageElement.innerHTML = '<span class="incorrect">Lo siento, has reprobado la prueba.</span>';
        }

        restartButton.style.display = 'inline-block';
    }

    function restart() {
        submitButton.disabled = false;
        startTest();
    }

    submitButton.addEventListener('click', checkAnswer);

    // Iniciar la prueba al cargar la página
    startTest();
</script>

</body>
</html>
