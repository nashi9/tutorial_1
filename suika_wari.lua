--アセットの取得
local Suika = vci.assets.GetSubItem("Suika")
local Suika_L = vci.assets.GetSubItem("Suika_wareL")
local Suika_R = vci.assets.GetSubItem("Suika_wareR")
local flag = false
local eff = vci.assets.GetEffekseerEmitter("Effect")
--割れたスイカの初期位置
Suika_L.SetLocalPosition(Vector3._new(0, -100, 0))
Suika_R.SetLocalPosition(Vector3._new(0, -100, 0))

--持っているときは割れないようにする
function onGrab(target)
    if target == "Suika" then
        flag = true
    end
end

function onUngrab(target2)
    if target2 == "Suika" then
        flag = false
    end
end

--衝突したときの処理
function onCollisionEnter(item, hit)
    if (item == "Suika" and hit == "suika_bou") or (item == "suika_bou" and hit == "Suika") then
        if flag == false then
            --エフェクトの再生
            edd._ALL_PlayOneShot()
            --元のスイカの位置の取得
            local Suika_pos = Suika.GetLocalPosition()

            --元のスイカの位置に割れたスイカを移動させる
            Suika_L.SetLocalPosition(Suika_pos)
            Suika_R.SetLocalPosition(Suika_pos)

            --回転と速度を0にする
            Suika_L.SetVelocity(Vector3.zero)
            Suika_R.SetVelocity(Vector3.zero)
            Suika_L.SetAngularVelocity(Vector3.zero)
            Suika_R.SetAngularVelocity(Vector3.zero)

            --元のスイカを移動させる
            Suika_pos = Vector3.__new(0, -100, 0)
            Suika.SetPosition(Suika_pos)
        end
    end
end
