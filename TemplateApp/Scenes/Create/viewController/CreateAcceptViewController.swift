import UIKit
import RxFlow
import RxSwift
import RxCocoa
import SnapKit

final class CreateAcceptViewController: UIViewController, Stepper, TopBarViewControllerType {
    let steps = PublishRelay<Step>()

    var createAcceptView: CreateAcceptViewType!

    var barViewController: TopBarViewController!

    private let disposeBag = DisposeBag()

    @discardableResult
    func configured() -> Self {
        view.backgroundColor = .white

        configureBarView()
        configureView()

        setupBarBindings()
        setupViewBindings()

        return self
    }
}

// MARK: UI
private extension CreateAcceptViewController {
    func configureBarView() {
        view.addSubview(barViewController.view)
        barViewController.detailBarView.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func configureView() {
        view.addSubview(createAcceptView)
        createAcceptView.snp.makeConstraints { maker in
            maker.top.equalTo(barViewController.view.snp_bottomMargin)
            maker.trailing.leading.bottom.equalToSuperview()
        }
    }
}

// MARK: Bindings
extension CreateAcceptViewController {
    private func setupBarBindings() {
        barViewController.steps
            .bind(to: steps)
            .disposed(by: disposeBag)
    }

    private func setupViewBindings() {
        createAcceptView.viewModel.onStepper
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}
