//
//  ImplementsStateMachine.swift
//  
//
//  Created by Stefan Ueter on 05.04.23.
//

import Foundation


public
protocol ImplementsStateMachine
{
    static
    func canTransition
    (
        from fromValue: Self,
        to toValue: Self
    )
    -> Bool
}
