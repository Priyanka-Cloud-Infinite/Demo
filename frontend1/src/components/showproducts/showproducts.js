import React from 'react';
import Auxi from '../../auxiliary/auxi';

const Person = (props) => {
    return(
        <Auxi>
            
             {props.name}  {props.price}
             <br/>

        </Auxi>
    )
}

export default Person;