//
//  ViewModel.swift
//  app-playground
//
//  Created by uehara yuki on 2022/06/14.
//

import UIKit
import RxSwift
import RxCocoa

struct Input {
    var tapAction: Observable<UITapGestureRecognizer>
    var textInput: Observable<String?>
}

final class ViewModel {
    private let disposeBag = DisposeBag()
    let labelText: Observable<String>
    let text: Observable<String?>

    init(
        event: Input
    ) {
        self.labelText = event.tapAction
            .flatMap({ _ -> Observable<String> in
                return .just("ok")
            })
        self.text = event.textInput
            .flatMap({ string -> Observable<String?> in
                return .just(string)
            })
    }
}
