//
//  StateMachine.swift
//  
//
//  Created by Stefan Ueter on 05.04.23.
//

import Foundation


@propertyWrapper
public
struct StateMachine<T: ImplementsStateMachine>
{
    var _value: T
    
    
    public
    init
    (
        wrappedValue: T
    )
    {
        self._value = wrappedValue
    }
    

    public
    var wrappedValue: T
    {
        get
        {
            self._value
        }
        
        set
        {
            self.setValue(newValue)
        }
    }
    
    
    mutating
    func setValue
    (
        _ value: T
    )
    {
        self.checkTransition(from: self._value,
                             to: value)
        
        self._value = value
    }
    
    
    func checkTransition
    (
        from fromValue: T,
        to toValue: T
    )
    {
        guard T.canTransition(from: fromValue,
                              to: toValue)
        else
        {
            let message = "invalid transition for type `\(String(describing: T.self))` from: `\(String(describing: fromValue))` to: `\(String(describing: toValue))`"
            
            fatalError(message)
        }
    }
}
