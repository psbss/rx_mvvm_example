//
//  ViewModel.swift
//  app-playground
//
//  Created by uehara yuki on 2022/06/14.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewModel {
    private let disposeBag = DisposeBag()
    let labelText: Observable<String>
    let text: Observable<String?>

    init(
        tapActionObservable: Observable<UITapGestureRecognizer>,
        textInputObservable: Observable<String?>
    ) {
        self.labelText = tapActionObservable
            .flatMap({ _ -> Observable<String> in
                return .just("ok")
            })
        self.text = textInputObservable
            .flatMap({ string -> Observable<String?> in
                return .just(string)
            })
    }
}
