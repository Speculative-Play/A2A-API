//Packages
import React, {useState } from 'react'
import styled from 'styled-components'

//Component
function QuestionComponent(props) {
    const [answer, setAnswer] = useState(0)
    const [isRemoved, setIsRemoved] = useState(false)
    const [isAsnwerVisible, setAnswerVisible] = useState(true)

    const handleAnswer = (value) => {
        setAnswer(value)
    }

    const handleRemoveQuestion = () => {
        setIsRemoved(true)
    }

    return (
        <div>
            {!props.readOnly && !props.notAdded &&
                <div className={isRemoved && 'display-none'}>
                    <QuestionDiv >
                        <div>Do you smoke?</div>
                        <div onClick={() => handleRemoveQuestion()} className='cursor-pointer'>
                            <i className='material-icons'>cancel</i>
                        </div>
                    </QuestionDiv>
                    {props.shortQuestion &&
                        <ShortAnswersContainer>
                            <ShortAnswerDiv onClick={() => handleAnswer(1)} className={answer === 1 && 'selected'}>
                                No I don't
                                {answer === 1 && (isAsnwerVisible ? <i className='material-icons cursor-pointer'>visibility</i> : <i className='material-icons cursor-pointer'>visibilityoff</i>)}
                            </ShortAnswerDiv>
                            <ShortAnswerDiv onClick={() => handleAnswer(2)} className={answer === 2 && 'selected'}>
                                Occasionally
                                {answer === 2 && (isAsnwerVisible ? <i className='material-icons cursor-pointer'>visibility</i> : <i className='material-icons cursor-pointer'>visibilityoff</i>)}
                            </ShortAnswerDiv>
                            <ShortAnswerDiv onClick={() => handleAnswer(3)} className={answer === 3 && 'selected'}>
                                Yes, I do
                                {answer === 3 && (isAsnwerVisible ? <i className='material-icons cursor-pointer'>visibility</i> : <i className='material-icons cursor-pointer'>visibilityoff</i>)}
                            </ShortAnswerDiv>
                        </ShortAnswersContainer>
                    }
                    {props.longQuestion &&
                        <LongAnswersContainer>
                            <ShortAnswerDiv onClick={() => handleAnswer(1)} className={answer === 1 && 'selected'}>I'm always cooking and trying new recipes
                            </ShortAnswerDiv>
                            <ShortAnswerDiv onClick={() => handleAnswer(2)} className={answer === 2 && 'selected'}>I like to cook occasionally
                            </ShortAnswerDiv>
                            <ShortAnswerDiv onClick={() => handleAnswer(3)} className={answer === 3 && 'selected'}>I only cook if I have to</ShortAnswerDiv>
                        </LongAnswersContainer>
                    }
                </div>
            }

            {props.readOnly &&
                <div>
                    <ReadOnlyQuestionDiv>
                        Do you drink alcohol?
                    </ReadOnlyQuestionDiv>
                    <ReadOnlyAnswerDiv>
                        Yes, socially
                    </ReadOnlyAnswerDiv>
                </div>
            }

            {props.notAdded &&
                <StyledDiv>
                    <div>How do you react to lovesickness?</div>
                    <div>
                        <i className='material-icons'>add</i>
                    </div>
                </StyledDiv>
            }
        </div>
    );
}

//Styling
const StyledDiv = styled.div`
    background: #FFFFFF;
    border: 2.5px solid #2684FF;
    box-sizing: border-box;
    border-radius: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 1rem;
    i {
        color: #2684FF;
    }
`;
const ReadOnlyAnswerDiv = styled.div`
    background: #B3D4FF;
    border-radius: 10px;
    padding: .55rem 1.1rem;
    text-align: left;
    font-family: 'Fira Sans';
    font-weight: 500;
    font-size: 18px;
    color: #FFFFFF;
`;
const ReadOnlyQuestionDiv = styled.div`
    color: #545454;
    margin-bottom: .45rem;
    text-align: left;
    padding-left: 10px;
`;
const QuestionDiv = styled.div`
    background: rgba(221, 221, 221, 0.27);
    border-radius: 10px;
    padding: .55rem 1.1rem;
    display: flex;
    justify-content: space-between;
    align-items:center;
    margin-bottom: 10px;
`;
const ShortAnswersContainer = styled.div`
    display: flex;
    gap: 10px;
`;
const LongAnswersContainer = styled.div`
    display: flex;
    gap: 10px;
    flex-direction: column;
`;
const ShortAnswerDiv = styled.div`
    background: rgba(221, 221, 221, 0.49);
    border-radius: 10px;
    text-align: left;
    min-width: 150px;
    padding: .55rem 1.1rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    &.selected{
        color: #FFFFFF;
        background: #B3D4FF;
    }
`;

export default QuestionComponent;
