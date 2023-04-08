//
//  StateMachine_Tests.swift
//  
//
//  Created by Stefan Ueter on 05.04.23.
//

import Foundation
@testable import StateMachine
import XCTest
import Nimble


class StateMachine_Tests: XCTestCase
{
    func test__valid_transition()
    {
        // arrange
        
        var sut_stateMachine = StateMachine<DummyState>(wrappedValue: .first)
        
        
        // act
        
        let act: (inout StateMachine<DummyState>) -> Void =
        {
            sut_stateMachine in
            
            sut_stateMachine.wrappedValue = .second
        }
        
        
        // assert
        
        expect
        {
            act(&sut_stateMachine)
        }
        .toNot(throwAssertion())
        
        guard case .second = sut_stateMachine.wrappedValue
        else
        {
            XCTFail()
            return
        }
    }
    
    
    func test__invalid_transition()
    {
        // arrange
        
        var sut_stateMachine = StateMachine<DummyState>(wrappedValue: .first)
        
        
        // act
        
        let act: (inout StateMachine<DummyState>) -> Void =
        {
            sut_stateMachine in
            
            sut_stateMachine.wrappedValue = .third
        }
        
        
        // assert
        
        expect
        {
            act(&sut_stateMachine)
        }
        .to(throwAssertion())
        
        guard case .first = sut_stateMachine.wrappedValue
        else
        {
            XCTFail()
            return
        }
    }
}


enum DummyState: ImplementsStateMachine
{
    case first
    
    case second
    
    case third
    
    
    static
    func canTransition
    (
        from fromValue: Self,
        to toValue: Self
    )
    -> Bool
    {
        switch (fromValue, toValue)
        {
            case
                (.first, .second),
                (.second, .third):
                
                return true
                
                
            default:
                
                return false
        }
    }
}
